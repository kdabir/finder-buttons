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

all: idea sublime sourcetree iterm

clean:
	@rm -rf *.app