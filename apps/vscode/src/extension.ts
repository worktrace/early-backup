import * as vscode from "vscode"

export function activate(context: vscode.ExtensionContext) {
  context.subscriptions.push(
    vscode.commands.registerCommand("worktrace.hello", () => {
      vscode.window.showInformationMessage("Hello from WorkTrace!")
    }),
  )
}
