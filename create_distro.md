How to create a release?
I have a question. When it comes to compiling the game to send to friends, in order to get feedback before deploying or uploading it to Steam...

How do you guys compile it into an .exe executable? In my case, my operating system is Linux, and I'm setting up a workflow with GitHub Actions to create a release every time I want a version I can send.

But all the methods I've tried give errors or require the user to install LÖVE.

And of course, regarding uploading to Steam, I wanted to know how to do it.


Upvote
6

Downvote

2
Go to comments


Share
u/adobe avatar
adobe
• Official
•
Promoted

Transform your photos with ease—Photoshop takes your look to the next level.
Learn More
adobe.com
Thumbnail image: Transform your photos with ease—Photoshop takes your look to the next level.
Join the conversation
Sort by:

Best

Search Comments
Expand comment search
Comments Section
Fair-Alternative8775
•
3h ago
Hi i used this for my project : https://github.com/pfirsich/makelove check it out i even got it to work with ci/cd pipelines so definitely worth to look at

track me

Upvote
4

Downvote

Reply
reply

Award

Share

jojopov
•
2h ago
•
Edited 2h ago
First download windows 32-bits installer zip archive from here https://www.love2d.org/
Assuming that your project repository is like that:
build/
tools/
main.lua
conf.lua

- extract the archive into tools/love-11.5-win32/ folder.
-then compile your project into a .love file
zip -9 -r yourProject.love . -x ".git*" "*.DS_Store" "*~" "tools/*" "build/*"

-create a build directory:
mkdir -p build/windows

-create your .exe file
cat tools/love-11.5-win32/love.exe yourProject.love > build/windows/yourProject.exe

-copy all needed files into the build directory:
cp tools/love-11.5-win32/*.dll build/windows/

cp tools/love-11.5-win32/license.txt build/windows/

Then go to windows folder:
cd build/windows

and zip all !
zip-9 -r yourProject.zip .