@rem https://love2d.org/forums/viewtopic.php?t=89211&p=235036
@rem Version Manager for LOVE

@REM @echo off 




@REM @Echo Off & Setlocal DisableDelayedExpansion
@REM mode 170,40
@REM ::: { Creates variable /AE = Ascii-27 escape code.
@REM ::: - %/AE% can be used  with and without DelayedExpansion.
@REM     For /F %%a in ('echo prompt $E ^| cmd')do set "/AE=%%a"
@REM ::: }

@REM (Set \n=^^^
@REM %=Newline DNR=%
@REM )
@REM ::: / Color Print Macro -
@REM ::: Usage: %Print%{RRR;GGG;BBB}text to output
@REM ::: \n at the end of the string echo's a new line
@REM ::: valid range for RGB values: 0 - 255
@REM   Set Print=For %%n in (1 2)Do If %%n==2 (%\n%
@REM     For /F "Delims=" %%G in ("!Args!")Do (%\n%
@REM       For /F "Tokens=1 Delims={}" %%i in ("%%G")Do Set "Output=%/AE%[0m%/AE%[38;2;%%im!Args:{%%~i}=!"%\n%
@REM       ^< Nul set /P "=!Output:\n=!%/AE%[0m"%\n%
@REM       If "!Output:~-2!"=="\n" (Echo/^&Endlocal)Else (Endlocal)%\n%
@REM     )%\n%
@REM   )Else Setlocal EnableDelayedExpansion ^& Set Args=
@REM ::: / Erase Macro -
@REM ::: Usage: %Erase%{string of the length to be erased}
@REM   Set Erase=For %%n in (1 2)Do If %%n==2 (%\n%
@REM     For /F "Tokens=1 Delims={}" %%G in ("!Args!")Do (%\n%
@REM       Set "Nul=!Args:{%%G}=%%G!"%\n%
@REM       For /L %%# in (0 1 100) Do (If Not "!Nul:~%%#,1!"=="" ^< Nul set /P "=%/AE%[D%/AE%[K")%\n%
@REM     )%\n%
@REM     Endlocal%\n%
@REM   )Else Setlocal EnableDelayedExpansion ^& Set Args=

@REM rem // usage example
@REM  %Print%{150;75;50}This is a Demo
@REM  %Print%{140;60;120} of same line multicolor output.\n
@REM  %Print%{75;190;150}Includes End Of Line marker.
@REM  Timeout 1 /NoBreak > Nul
@REM  %Erase%{marker.}
@REM  %Print%{150;150;80}marker and erase macro.\n


@REM https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html

@ECHO OFF
SETLOCAL EnableExtensions DisableDelayedExpansion
for /F %%a in ('echo prompt $E ^| cmd') do (
  set "ESC=%%a"
)

:: eventually we want to be able to input the version we want and auto-select conf'd
TITLE "Invadors Console Log"

:: Below is a bunch of stuff about launching the game with logging enabled

echo ^<run.BAT^> %ESC%[4m-run.bat-%ESC%[0m
@REM echo ^<ESC^>[4m %ESC%[4mDisableDelayedExpansion%ESC%[0m
echo.
echo.
echo %ESC%[4m %DATE% - %TIME% %ESC%[0m
echo.
@REM echo %ESC%[4m %PATH% %ESC%[0m
echo ^<run.BAT^> %ESC%[4m-run.bat-%ESC%[0m
echo %ESC%[%ESC%[0m
@REM echo %ESC%[4m %ESC%[0m
@REM echo ^<ESC^>[4m %ESC%[4mDisableDelayedExpansion%ESC%[0m
echo %ESC%[4m Begin LOVE.exe execution %ESC%[0m
echo %ESC%[%ESC%[0m
@REM echo %ESC%[4m %ESC%[0m

@REM SETLOCAL EnableDelayedExpansion

@REM echo !ESC![101;93m STYLES !ESC![0m
@REM echo ^<ESC^>[4m !ESC![4mUnderline!ESC![0m
@REM echo ^<ESC^>[0m !ESC![0mReset!ESC![0m
@REM echo ^<ESC^>[1m !ESC![1mBold!ESC![0m
@REM echo ^<ESC^>[7m !ESC![7mInverse!ESC![0m
@REM echo.
@REM echo !ESC![101;93m NORMAL FOREGROUND COLORS !ESC![0m
@REM echo ^<ESC^>[30m !ESC![30mBlack!ESC![0m (black)
@REM echo ^<ESC^>[31m !ESC![31mRed!ESC![0m
@REM echo ^<ESC^>[32m !ESC![32mGreen!ESC![0m
@REM echo ^<ESC^>[33m !ESC![33mYellow!ESC![0m
@REM echo ^<ESC^>[34m !ESC![34mBlue!ESC![0m
@REM echo ^<ESC^>[35m !ESC![35mMagenta!ESC![0m
@REM echo ^<ESC^>[36m !ESC![36mCyan!ESC![0m
@REM echo ^<ESC^>[37m !ESC![37mWhite!ESC![0m
@REM echo.
@REM echo !ESC![101;93m NORMAL BACKGROUND COLORS !ESC![0m
@REM echo ^<ESC^>[40m !ESC![40mBlack!ESC![0m
@REM echo ^<ESC^>[41m !ESC![41mRed!ESC![0m
@REM echo ^<ESC^>[42m !ESC![42mGreen!ESC![0m
@REM echo ^<ESC^>[43m !ESC![43mYellow!ESC![0m
@REM echo ^<ESC^>[44m !ESC![44mBlue!ESC![0m
@REM echo ^<ESC^>[45m !ESC![45mMagenta!ESC![0m
@REM echo ^<ESC^>[46m !ESC![46mCyan!ESC![0m
@REM echo ^<ESC^>[47m !ESC![47mWhite!ESC![0m (white)
@REM echo.
@REM echo !ESC![101;93m STRONG FOREGROUND COLORS !ESC![0m
@REM echo ^<ESC^>[90m !ESC![90mWhite!ESC![0m
@REM echo ^<ESC^>[91m !ESC![91mRed!ESC![0m
@REM echo ^<ESC^>[92m !ESC![92mGreen!ESC![0m
@REM echo ^<ESC^>[93m !ESC![93mYellow!ESC![0m
@REM echo ^<ESC^>[94m !ESC![94mBlue!ESC![0m
@REM echo ^<ESC^>[95m !ESC![95mMagenta!ESC![0m
@REM echo ^<ESC^>[96m !ESC![96mCyan!ESC![0m
@REM echo ^<ESC^>[97m !ESC![97mWhite!ESC![0m
@REM echo.
@REM echo !ESC![101;93m STRONG BACKGROUND COLORS !ESC![0m
@REM echo ^<ESC^>[100m !ESC![100mBlack!ESC![0m
@REM echo ^<ESC^>[101m !ESC![101mRed!ESC![0m
@REM echo ^<ESC^>[102m !ESC![102mGreen!ESC![0m
@REM echo ^<ESC^>[103m !ESC![103mYellow!ESC![0m
@REM echo ^<ESC^>[104m !ESC![104mBlue!ESC![0m
@REM echo ^<ESC^>[105m !ESC![105mMagenta!ESC![0m
@REM echo ^<ESC^>[106m !ESC![106mCyan!ESC![0m
@REM echo ^<ESC^>[107m !ESC![107mWhite!ESC![0m
@REM echo.
@REM echo !ESC![101;93m COMBINATIONS !ESC![0m
@REM echo ^<ESC^>[31m                     !ESC![31mred foreground color!ESC![0m
@REM echo ^<ESC^>[7m                      !ESC![7minverse foreground ^<-^> background!ESC![0m
@REM echo ^<ESC^>[7;31m                   !ESC![7;31minverse red foreground color!ESC![0m
@REM echo ^<ESC^>[7m and nested !ESC![31m !ESC![7mbefore !ESC![31mnested!ESC![0m
@REM echo ^<ESC^>[31m and nested !ESC![7m !ESC![31mbefore !ESC![7mnested!ESC![0m






@REM this works for 10.2
@REM start %CD%\lib\love\10.2\love.exe %CD%\

@REM 11.3 is broken currently
@REM start %CD%\lib\love\11.3\love.exe %CD%\ > lastrunbat.txt
start %CD%\lib\love\10.2\love.exe %CD%\ > lastrunbat.txt

@REM attaches a consoel
@REM start %CD%\lib\love\11.3\lovec.exe %CD%\ "run.BAT"

@REM https://ss64.com/nt/start.html

@REM start %CD%\lib\love\11.3\love.exe %CD%\ "run.BAT"
@REM echo %1 

@REM exit

@REM start cecho {0C}Hello world!{#}{\n}

@REM @ECHO OFF

@REM keep open - this prevents the console from closing
@REM cmd /k