-- Opens selected files/folders in the target app. If nothing selected, opens current folder.
-- Placeholder: {{APP_NAME}} = target application name

on run
	tell application "Finder"
		if selection is {} then
			try
				set theList to {folder of the front window as alias}
			on error
				return
			end try
		else
			set theList to selection as alias list
		end if
	end tell
	open_in_app(theList)
end run

on open(theList)
	open_in_app(theList)
end open

on open_in_app(listOfItems)
	tell application "{{APP_NAME}}"
		activate
		open listOfItems
	end tell
end open_in_app
