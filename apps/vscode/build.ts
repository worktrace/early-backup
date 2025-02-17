import nodeResolve from "@rollup/plugin-node-resolve"
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"
import {
  cpSync,
  mkdirSync,
  readdirSync,
  readFileSync,
  rmSync,
  writeFileSync,
} from "node:fs"
import { join } from "node:path"
import { rollup } from "rollup"

/**
 * Copy and edit the manifest configuration from a node package for development
 * propose into a vscode extension manifest for production.
 * Unnecessary fields will be removed.
 *
 * @param src path to the input folder where package.json locates.
 * @param out path to the output folder where package.json locates.
 * @param main override entry of the output extension script.
 */
function compileManifest(src: string, out: string, main?: string) {
  const raw = readFileSync(join(src, "package.json")).toString()
  const manifest = JSON.parse(raw)

  manifest.type = undefined
  manifest.private = undefined
  manifest.scripts = undefined
  manifest.dependencies = undefined
  manifest.devDependencies = undefined
  manifest.peerDependencies = undefined

  if (main) manifest.main = main
  writeFileSync(join(out, "package.json"), JSON.stringify(manifest))
}

function copyAssets(src: string, out: string, items: string[]) {
  for (const item of items) {
    const srcPath = join(src, item)
    const outPath = join(out, item)
    cpSync(srcPath, outPath, { recursive: true })
  }
}

function emptyFolder(root: string) {
  mkdirSync(root, { recursive: true })
  for (const item of readdirSync(root)) {
    rmSync(join(root, item), { recursive: true })
  }
}

async function bundleExtension(
  src: string,
  out: string,
  tsconfigPath?: string,
) {
  const bundle = await rollup({
    plugins: [typescript({ tsconfig: tsconfigPath }), nodeResolve(), terser()],
    input: src,
    external(source, _importer, isResolved) {
      if (isResolved) return false
      return source == "vscode" || source.startsWith("node:")
    },
  })
  await bundle.write({ file: out, format: "commonjs" })
}

async function main() {
  const root = import.meta.dirname
  const src = join(root, "src")
  const out = join(root, "out")
  const outFilename = "extension.js"
  emptyFolder(out)
  copyAssets(root, out, ["README.md", "LICENSE.txt"])
  copyAssets(src, out, ["themes"])

  compileManifest(root, out, outFilename)
  await bundleExtension(
    join(src, "extension.ts"),
    join(out, outFilename),
    join(root, "tsconfig.json"),
  )
}
main()
