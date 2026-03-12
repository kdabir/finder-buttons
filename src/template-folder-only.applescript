-- Folder only: rejects if any selected item is a file.
-- Placeholder: {{APP_NAME}}

on run
	set theList to get_selection()
	if theList is {} then return
	if not validate_folder_only(theList) then return
	open_in_app(theList)
end run

on open(theList)
	if not validate_folder_only(theList) then return
	open_in_app(theList)
end open

on get_selection()
	tell application "Finder"
		if selection is {} then
			try
				return {folder of the front window as alias}
			on error
				return {}
			end try
		else
			return selection as alias list
		end if
	end tell
end get_selection

on validate_folder_only(theList)
	tell application "Finder"
		repeat with theItem in theList
			try
				if (kind of item theItem is not "Folder") and (kind of item theItem is not "Volume") then
					display dialog "Please select folders only (no files)." buttons {"OK"} default button "OK" with icon stop
					return false
				end if
			end try
		end repeat
	end tell
	return true
end validate_folder_only

on open_in_app(listOfItems)
	tell application "{{APP_NAME}}"
		activate
		open listOfItems
	end tell
end open_in_app
