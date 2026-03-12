# Developing

## Project Structure
- **Templates** (`src/template-*.applescript`) – one per strategy, chosen via build script 3rd argument:
  - **default** – pass-through: selection or current folder (files, folders, or mixed) is sent to the app.
  - **file-only** – rejects if any selected item is a folder; only files are passed.
  - **folder-only** – rejects if any selected item is a file; only folders are passed (e.g. Terminal, iTerm, WebStorm).
  - **file-parent** – if a file is selected, uses its parent folder instead; folders pass through (e.g. “open folder in Terminal” when a file is selected).
- `res/` – application icons (`.icns`).
- `build/` – temp dir for compiled AppleScripts.
- `dist/` – built droplets.
- `scripts/build.sh` – builds one droplet (app name, droplet name, strategy).
- `scripts/extract-icon.sh` – copies app icon into `res/`.
- `Makefile` – `make all`, `make <app>`, `make extract-icon`, `make clean`.

## Adding a New App

1. **Extract the icon**
   ```bash
   make extract-icon APP="MyApp"
   # or
   make extract-icon APP="~/Applications/MyApp.app"
   ```
   Rename the file in `res/` if needed (e.g. to match the short name you’ll use for the droplet).

   eg. `make extract-icon APP="Kiro"`, `make extract-icon APP="AntiGravity"`

2. **Add a Makefile target**
   ```makefile
   myapp:
       @./scripts/build.sh "My App" "Open in MyApp"
   ```
   Add `myapp` to the `APPS` list so `make all` builds it.

3. **Build**
   ```bash
   make myapp
   # or
   ./scripts/build.sh "My App" "Open in MyApp"
   ```

## Build script

```bash
./scripts/build.sh "<App name or path>" "[Droplet name]"
```
Droplet name defaults to `Open in <App name>`. Icon is taken from `res/<DropletName>.icns` or `res/<name without "Open in ">.icns` or `res/<App name>.icns`.




## Git diffs

Add to `.git/config`

```
[diff "scpt"]
  textconv = osadecompile
  binary=true
```
