setup:
	cat .gitconfig >> .git/config

iterm:
	osacompile -o "Open in iTerm.app" src/open-in-iterm.applescript
	cp res/iTerm.icns Open\ in\ iTerm.app/Contents/Resources/droplet.icns

sublime:
	osacompile -o "Open in Sublime Text.app" src/open-in-sublime-text.applescript
	cp res/sublime-text.icns Open\ in\ Sublime\ Text.app/Contents/Resources/droplet.icns

sourcetree:
	osacompile -o "Open in SourceTree.app" src/open-in-sourcetree.applescript
	cp res/sourcetree.icns Open\ in\ SourceTree.app/Contents/Resources/droplet.icns

idea:
	osacompile -o "Open in IDEA.app" src/open-in-idea.applescript
	cp res/idea.icns Open\ in\ IDEA.app/Contents/Resources/droplet.icns
