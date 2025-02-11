import nodeResolve from "@rollup/plugin-node-resolve"
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"
import { mkdirSync } from "node:fs"
import { join } from "node:path"
import { rollup } from "rollup"

async function bundleExtension(src: string, out: string) {
  const bundle = await rollup({
    plugins: [typescript(), nodeResolve(), terser()],
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
  const out = join(root, "out")
  mkdirSync(out, { recursive: true })

  await bundleExtension(
    join(root, "src", "extension.ts"),
    join(out, "extension.js"),
  )
}
main()
