@ECHO OFF

SET RootPath=%~dp0

SET TestPath=%RootPath%fireball_tests
SET FBCCPath=%RootPath%bin\Debug

SET FBCCExe="fbcc.exe"
SET FBTester="Fireball.Compiler.Tester.exe"

rem ECHO Using FBCC @ %FBCCPath%
rem ECHO Using FBCC Executable %FBCCExe%

ECHO Using Tests in %TestPath%
ECHO Using FB Tester Executable %FBTester%

ECHO Cleaning up...
@DEL /Q "%TestPath%\output\*.*"

ECHO Running Positive tests...
@COPY "%TestPath%\positive\*.fb" "%TestPath%\output\

"%TestPath%\%FBTester%" -p:-nowarn:10003,168 -d:"%TestPath%\output"

ECHO Running Negative tests...
@DEL /Q "%TestPath%\output\*.*"
@COPY "%TestPath%\negative\*.fb" "%TestPath%\output\

"%TestPath%\%FBTester%" -p:-nowarn:10003,168 -d:"%TestPath%\output"

@DEL /Q "%TestPath%\output\*.*"
pause

