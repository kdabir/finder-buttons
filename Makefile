# Build all droplets (add a line per app to support)
APPS = vscode cursor sublime idea terminal iterm sourcetree zed webstorm codex kiro antigravity
all: $(APPS)

sublime:
	@./scripts/build.sh "Sublime Text" "Open in SublimeText"

zed:
	@./scripts/build.sh "Zed" "Open in Zed"

idea:
	@./scripts/build.sh "IntelliJ IDEA" "Open in IDEA" 

webstorm:
	@./scripts/build.sh "WebStorm" "Open in WebStorm"

vscode:
	@./scripts/build.sh "Visual Studio Code" "Open in VSCode"

cursor:
	@./scripts/build.sh "Cursor" "Open in Cursor"

terminal:
	@./scripts/build.sh "Terminal" "Open in Terminal" "file-parent"

iterm:
	@./scripts/build.sh "iTerm" "Open in iTerm" "file-parent"

sourcetree:
	@./scripts/build.sh "SourceTree" "Open in SourceTree" "folder-only"

codex:
	@./scripts/build.sh "Codex" "Open in Codex"

kiro:
	@./scripts/build.sh "Kiro" "Open in Kiro"

antigravity:
	@./scripts/build.sh "Antigravity" "Open in Antigravity"

# Usage: make extract-icon APP="IntelliJ IDEA" or APP="/path/to/App.app"
ifeq (extract-icon,$(firstword $(MAKECMDGOALS)))
  EXTRACT_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(EXTRACT_ARGS):;@:)
endif
extract-icon:
	@./scripts/extract-icon.sh "$(if $(APP),$(APP),$(EXTRACT_ARGS))"

clean:
	rm -rf dist/*.app build/

.PHONY: all clean extract-icon $(APPS)
