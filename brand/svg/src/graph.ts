import { html } from "lit"
import { renderDom } from "./svg"

interface LogoOptions {
  size?: number
}

export function createLogo(options?: LogoOptions): string {
  const size = (options?.size ?? 1024).toString()

  const xmlHeader = `<?xml version="1.0"?>`
  const dom = html`
    <svg
      version="1.1"
      width=${size}
      height=${size}
      viewBox="0 0 ${size} ${size}"
    >
      <g id="logo">
        <rect></rect>
      </g>
    </svg>
  `
  return `${xmlHeader}${renderDom(dom)}`
}
