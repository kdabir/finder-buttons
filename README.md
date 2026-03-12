# MacOS Finder Buttons

![image](https://user-images.githubusercontent.com/735240/64318162-0dec0280-cfd7-11e9-9a20-4c182aa7c811.png)


Buttons to open current finder selection (file/folder) in following apps:

- Antigravity
- Codex
- Cursor
- IntelliJ IDEA
- iTerm
- Kiro
- SourceTree
- SublimeText
- Terminal
- VSCode
- WebStorm
- Zed

#### Installing

Download the release zip, unzip it, then drag the `.app` icons to the Finder toolbar.

**If macOS says the app is "damaged"** (common when downloading unsigned apps): open Terminal and run this from the folder where you unzipped, to clear the download quarantine:

```bash
xattr -cr *.app
```

Then command+drag the icons to the Finder toolbar.

![install](https://user-images.githubusercontent.com/735240/36919049-f5c33b0e-1e81-11e8-9c70-424d2e9ff753.gif)

### Building Locally

Git clone and run `make all`, `*.app`s will be generated in the `dist` dir

#### Using
![using](https://user-images.githubusercontent.com/735240/36919050-f73cb0d2-1e81-11e8-80d0-6fc27ddfa38e.gif)


#### Uninstalling
![uninstall](https://user-images.githubusercontent.com/735240/36919048-f3b2a232-1e81-11e8-99a7-09641a96e6ad.gif)


## Allow Access

<img width="372" alt="image" src="https://github.com/kdabir/finder-buttons/assets/735240/51b8146b-ea9b-4039-9bdd-4f3b469b61fd">


