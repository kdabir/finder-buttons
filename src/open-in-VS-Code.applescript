-- on button click
on run
  tell application "Finder"
    if selection is {} then
      set finderSelection to folder of the front window as string
    else
      set finderSelection to selection as alias list
    end if
  end tell

  notify_app(finderSelection)
end run

-- on drop
on open(theList)
  notify_app(theList)
end open

-- open files/dir in app
on notify_app(listOfFilesOrDirs)
  tell application "Visual Studio Code"
    activate
    open listOfFilesOrDirs
  end tell
end notify_app