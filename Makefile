setup:
	cat .gitconfig >> .git/config

iterm:
	@osacompile -o "OpenInITerm.app" src/open-in-iterm.applescript
	@cp res/iTerm.icns OpenInITerm.app/Contents/Resources/droplet.icns

sublime:
	@osacompile -o "OpenInSublimeText.app" src/open-in-sublime-text.applescript
	@cp res/sublime-text.icns OpenInSublimeText.app/Contents/Resources/droplet.icns

sourcetree:
	@osacompile -o "OpenInSourceTree.app" src/open-in-sourcetree.applescript
	@cp res/sourcetree.icns OpenInSourceTree.app/Contents/Resources/droplet.icns

idea:
	@osacompile -o "OpenInIDEA.app" src/open-in-idea.applescript
	@cp res/idea.icns OpenInIDEA.app/Contents/Resources/droplet.icns

vscode:
	@osacompile -o "OpenInVSCode.app" src/open-in-VS-Code.applescript
	@cp res/vsCode.icns OpenInVSCode.app/Contents/Resources/droplet.icns


terminal:
	@osacompile -o "OpenInTerminal.app" src/open-in-terminal.applescript
	@cp res/terminal.icns OpenInTerminal.app/Contents/Resources/droplet.icns


all: idea sublime sourcetree iterm vscode terminal

clean:
	@rm -rf *.app