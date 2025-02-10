// This script is here because the lib cannot build itself.
import { readFileSync } from "node:fs"
import { join } from "node:path"

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
    const { source, esm, cjs, dts } = item as ExportPaths
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

async function main() {}
main()
