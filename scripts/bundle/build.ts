// This script is here because the lib cannot build itself.
import terser from "@rollup/plugin-terser"
import typescript from "@rollup/plugin-typescript"
import { readFileSync } from "node:fs"
import { join, normalize } from "node:path"
import { rollup } from "rollup"

export interface ExportPaths {
  /**
   * This field is not defined in package.json specification,
   * but required by this package to tell the compiler where the entry is.
   */
  source: string
  cjs: string
  esm: string
  dts: string
}

/**
 * There might be one or more layer of export path defines.
 * @param root path to the root folder where package.json locates.
 */
export function parseExportPaths(root: string): ExportPaths[] {
  const manifest = readFileSync(join(root, "package.json")).toString()
  const exports = JSON.parse(manifest)["exports"]

  /**
   * Parse a single layer of path configuration:
   * All properties must be satisfied when using this package.
   */
  const parseSingleLayer = (item: unknown): ExportPaths | null => {
    if (typeof item !== "object" || item === null) return null
    const source = item["source"]
    const esm = item["import"]
    const cjs = item["require"]
    const dts = item["types"]
    if (typeof source !== "string") return null
    if (typeof esm !== "string") return null
    if (typeof cjs !== "string") return null
    if (typeof dts !== "string") return null
    return { source, esm, cjs, dts }
  }

  // Only a single layer define in the root.
  const rootItem = parseSingleLayer(exports)
  if (rootItem) return [rootItem]

  // Resolve multiple entries.
  const handler: ExportPaths[] = []
  for (const [_key, value] of Object.entries(exports)) {
    const item = parseSingleLayer(value)
    if (item) handler.push(item)
  }
  return handler
}

export async function bundle(
  root: string,
  paths: ExportPaths,
  tsconfigPath?: string,
) {
  const bundle = await rollup({
    plugins: [typescript({ tsconfig: tsconfigPath }), terser()],
    input: normalize(join(root, paths.source)),
    external(source, _importer, isResolved) {
      if (isResolved) return false
      return source.startsWith("node:")
    },
  })
  await bundle.write({
    file: normalize(join(root, paths.esm)),
    format: "esm",
    sourcemap: true,
  })
  await bundle.write({
    file: normalize(join(root, paths.cjs)),
    format: "commonjs",
    sourcemap: true,
  })
}

export async function bundlePackage(root: string, tsconfigPath?: string) {
  await Promise.all(
    parseExportPaths(root).map((paths) => bundle(root, paths, tsconfigPath)),
  )
}

async function main() {
  const root = import.meta.dirname
  await bundlePackage(root, join(root, "tsconfig.json"))
}
main()
