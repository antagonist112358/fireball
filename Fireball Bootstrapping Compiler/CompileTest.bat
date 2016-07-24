@echo off
echo Compiling test: %1
if [%3]==[lib] goto library
bin\Debug\fbcc fireball_tests\positive\%1 -o %2
goto :eof
:library
bin\Debug\fbcc fireball_tests\positive\%1 -o %2 -t:Library