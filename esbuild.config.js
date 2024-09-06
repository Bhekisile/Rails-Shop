// import path from 'path'
import rails from 'esbuild-rails'

require('esbuild').build({
  entryPoints: ['app/javascript/application.js'],
  bundle: true,
  external: ['@hotwired/turbo-rails', '@hotwired/stimulus-loading'],  // Exclude from bundle
  outdir: 'app/assets/builds',
  plugins: [rails()],
}).catch(() => process.exit(1))
