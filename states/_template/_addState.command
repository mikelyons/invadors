# _addState.command
#
# a bash / apple script to create directories and files 
# from a template into a new gamestate with proper naming
# apple scripts (osascript): https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html#//apple_ref/doc/uid/TP40000983-CH216-SW11
# @TODO - allow the user to specify the gamestate name


# basic structure to create a state folder and file
-- tell application "Finder"
--   -- Create a new folder
--   set newFolderPath to POSIX path of (path to desktop from folder) & "NewFolder/"
--   make new folder at desktop with properties {name:"NewFolder"}
  
--   -- Create a new file within the folder
--   set newFilePath to POSIX path of (path to desktop from folder) & "NewFolder/NewFile.txt"
--   make new file at newFolderPath with properties {name:"NewFile.txt"}
-- end tell
