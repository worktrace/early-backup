import { join } from "node:path"
import { defineConfig } from "vite"

const root = import.meta.dirname

export default defineConfig({
  build: {
    outDir: join(root, "out"),
    emptyOutDir: true,
    rollupOptions: {
      output: {
        assetFileNames: "[hash].[ext]",
        chunkFileNames: "[hash].js",
        entryFileNames: "[hash].js",
      },
    },
  },
})
