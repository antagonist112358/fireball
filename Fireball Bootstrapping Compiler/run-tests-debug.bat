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
>NUL COPY "%TestPath%\positive\*.fb" "%TestPath%\output\
>NUL COPY "%FBCCPath%\Fireball.dll" "%TestPath%\output\

"%FBCCPath%\%FBTester%" -p:-nowarn:10003,168 -debugger -d:"%TestPath%\output"

PAUSE

@DEL /Q "%TestPath%\output\*.*"

ECHO Running Negative tests...

>NUL COPY "%TestPath%\negative\*.fb" "%TestPath%\output\
>NUL COPY "%FBCCPath%\Fireball.dll" "%TestPath%\output\

"%FBCCPath%\%FBTester%" -p:-nowarn:10003,168 -debugger -d:"%TestPath%\output"

PAUSE

@DEL /Q "%TestPath%\output\*.*"


