import nodeResolve from "@rollup/plugin-node-resolve"
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"
import { mkdirSync, readFileSync, writeFileSync } from "node:fs"
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

  manifest.private = undefined
  manifest.scripts = undefined
  manifest.dependencies = undefined
  manifest.devDependencies = undefined
  manifest.peerDependencies = undefined

  if (main) manifest.main = main
  writeFileSync(join(out, "package.json"), JSON.stringify(manifest))
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
  await bundle.write({ file: out, format: "esm" })
}

async function main() {
  const root = import.meta.dirname
  const out = join(root, "out")
  const outFilename = "extension.js"
  mkdirSync(out, { recursive: true })

  compileManifest(root, out, outFilename)
  await bundleExtension(
    join(root, "src", "extension.ts"),
    join(out, outFilename),
    join(root, "tsconfig.json"),
  )
}
main()
