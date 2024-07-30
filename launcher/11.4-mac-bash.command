# 10.2-mac-bash.command
# This script will launch the game with the build in love version 10.2 on bash for mac

#!/bin/bash
exec $(dirname "$0")/../lib/love/11.4/mac/love.app/Contents/MacOS/love "$(dirname "$0")/../"