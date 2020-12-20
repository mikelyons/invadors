@rem https://love2d.org/forums/viewtopic.php?t=89211&p=235036
@rem Version Manager for LOVE

@echo off 
@REM eventually we want to be able to input the version we want and auto-select conf'd

@REM this works for 10.2
@REM start %CD%\lib\love\10.2\love.exe %CD%\

@REM 11.3 is broken currently
start %CD%\lib\love\11.3\love.exe %CD%\

@REM echo %1 

exit