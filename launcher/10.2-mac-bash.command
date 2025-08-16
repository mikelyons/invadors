# 10.2-mac-bash.command
# This script will launch the game with the build in love version 10.2 on bash for mac
# apple scripts (osascript): https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html#//apple_ref/doc/uid/TP40000983-CH216-SW11

#!/bin/bash
osascript <<EOF
-- to get the screen dimensions and size the terminal correctly
-- tell application "System Events"
--    set screenResolution to size of display 1
--    set screenHeight to item 2 of screenResolution
-- end tell

-- screenHeight

beep

-- say "Welcome to invadort Z welcome"

-- display alert "Insert generic warning here." ¬
--     buttons {"Cancel", "OK"} as warning ¬
--     default button "Cancel" cancel button "Cancel" giving up after 5
-- display dialog
-- display notification

-- change the icon of this notification by converting this script to an application: https://stackoverflow.com/a/58915762/637283
-- TURN THIS BACK ON TODO
-- display notification "WELCOME TO INVADORTZ" with title "InvadortZ" subtitle "The game that will utterly obliterate you." sound name "Sosumi"

-- say "Reticulating splines"
-- tell application "Terminal"
tell application "iTerm2"
    activate
    set win to front window
    set bounds of win to {0, 0, 800, 800} -- {left, top, right, bottom}
end tell
EOF
exec $(dirname "$0")/../lib/love/10.2/mac/love.app/Contents/MacOS/love "$(dirname "$0")/../"

echo "Script finished - 10.2-mac-bash.command"
exit 0
