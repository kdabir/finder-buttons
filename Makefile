setup:
	cat .gitconfig >> .git/config

iterm:
	osacompile -o "Open in iTerm.app" src/open-in-iterm.applescript

sublime:
	osacompile -o "Open in Sublime Text.app" src/open-in-sublime-text.applescript

sourcetree:
	osacompile -o "Open in SourceTree.app" src/open-in-iterm.applescript