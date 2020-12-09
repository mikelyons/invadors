@echo off 
@REM eventually we want to be able to input the version we want and auto-select conf'd

@REM this works for 10.2
start %CD%\lib\love\10.2\love.exe %CD%\

@REM 11.3 is broken currently
@REM start %CD%\lib\love\11.3\love.exe %CD%\

@REM echo %1 

exit