import { execSync, spawn } from "node:child_process"

export async function shell(command: string) {
  execSync(command, { stdio: "inherit" })
  return new Promise<number>((resolve, reject) => {
    let process = spawn(command, { shell: true })
    process.stdout.on("data", (data) => console.log(data.toString()))
    process.stderr.on("data", (data) => console.log(data.toString()))
    process.on("disconnect", () => {
      console.log("disconnect")
      reject(1)
    })
    process.on("exit", (code) => {
      if (code === 0) {
        resolve(code)
      } else {
        reject(code)
      }
    })
    process.on("close", (code) => {
      if (code === 0) {
        resolve(code)
      } else {
        reject(code)
      }
    })
  })
}
