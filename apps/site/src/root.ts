import { css, html, LitElement, type PropertyValues } from "lit"
import { customElement } from "lit/decorators.js"

@customElement("app-root")
export class AppRoot extends LitElement {
  protected firstUpdated(_changedProperties: PropertyValues) {
    document.title = "WorkTrace"
  }

  protected override render() {
    return html`it works`
  }

  static styles = css`
    :host {
      width: 100%;
      height: 100%;

      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
  `
}
