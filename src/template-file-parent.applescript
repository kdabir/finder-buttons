-- File-parent: if a file is selected, use its parent folder; folders pass through.
-- Placeholder: {{APP_NAME}}

on run
	set theList to get_selection()
	if theList is {} then return
	set resolved to resolve_to_folders(theList)
	if resolved is not {} then
		open_in_app(resolved)
	end if
end run

on open(theList)
	set resolved to resolve_to_folders(theList)
	if resolved is not {} then
		open_in_app(resolved)
	end if
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

on resolve_to_folders(theList)
	set resultList to {}
	tell application "Finder"
		repeat with theItem in theList
			try
				if (kind of item theItem is "Folder") or (kind of item theItem is "Volume") then
					set end of resultList to theItem
				else
					set parentFolder to (container of item theItem) as alias
					set end of resultList to parentFolder
				end if
			end try
		end repeat
	end tell
	return resultList
end resolve_to_folders

on open_in_app(listOfItems)
	tell application "{{APP_NAME}}"
		activate
		open listOfItems
	end tell
end open_in_app
