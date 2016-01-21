@ECHO OFF

SET RootPath=%~dp0

SET TestPath=%RootPath%fireball_tests
SET FBCCPath=%RootPath%bin\Debug

SET FBCCExe="fbcc.exe"
SET FBTester="Fireball.Compiler.Tester.exe"

ECHO Using Tests in %TestPath%
ECHO Using FB Tester Executable %FBTester%

ECHO Cleaning up...
@DEL /Q "%TestPath%\output\*.*"

ECHO Running Positive tests...
>NUL COPY "%TestPath%\positive\*.fb" "%TestPath%\output\
>NUL COPY "%FBCCPath%\Fireball.dll" "%TestPath%\output\

"%FBCCPath%\%FBTester%" -p:-nowarn:10003,168 -d:"%TestPath%\output"

ECHO Running Negative tests...
@DEL /Q "%TestPath%\output\*.*"
>NUL COPY "%TestPath%\negative\*.fb" "%TestPath%\output\
>NUL COPY "%FBCCPath%\Fireball.dll" "%TestPath%\output\

"%FBCCPath%\%FBTester%" -p:-nowarn:10003,168 -d:"%TestPath%\output"

ECHO Cleaning up...
@DEL /Q "%TestPath%\output\*.*"

pause

