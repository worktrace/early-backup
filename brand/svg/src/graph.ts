import { html } from "lit"

export function renderLogo(): string {
  const xmlHeader = `<?xml version="1.0"?>`
  const dom = html`
    <svg>
      <g id="logo">
        <rect></rect>
      </g>
    </svg>
  `

  return `${xmlHeader}${dom.strings[0]}`
    .split("\n")
    .map((line) => line.trim())
    .join("")
}
