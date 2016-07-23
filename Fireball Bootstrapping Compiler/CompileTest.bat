@echo off
echo Compiling test: %1
bin\Debug\fbcc fireball_tests\positive\%1 -o %2