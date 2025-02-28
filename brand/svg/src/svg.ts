import { TemplateResult } from "lit"

/**
 * Render simple lit template in node environment without exact dom.
 */
export function renderDom(dom: TemplateResult): string {
  const sLen = dom.strings.length
  const vLen = dom.values.length
  if (sLen != dom.values.length + 1) {
    throw new Error(`invalid dom structure: strings[${sLen}] values[${vLen}]`)
  }

  const handler: string[] = [dom.strings[0].toString()]
  for (let i = 0; i < vLen; i++) {
    handler.push(`${dom.values[i]}`)
    handler.push(dom.strings[i + 1].toString())
  }

  return handler
    .join("")
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0)
    .join(" ")
    .replaceAll(/>\s+</g, "><")
}

export interface SvgComponent {
  element: string
  defs?: string
}

export function group(components: SvgComponent[]): SvgComponent {
  const elements = components.map((component) => component.element).join("")
  const defs = components
    .map((component) => component.defs)
    .filter((defs) => defs)

  return {
    element: `<g>${elements}</g>`,
    defs: defs.length > 0 ? defs.join("") : undefined,
  }
}
