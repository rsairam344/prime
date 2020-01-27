@echo off

rem deleting possible previous demo generated files.
if exist MON.sym del MON.sym
if exist MON.dat del MON.dat
if exist profile.txt del profile.txt
if "%OS%" == "Windows_NT" goto is_nt
if exist CTCHTML\index.html deltree /y CTCHTML
goto over
:is_nt
if exist CTCHTML rmdir /s /q CTCHTML
:over

echo.
echo Now instrumenting the example program prime.exe with CTC++.
echo Prime.exe is a simple program consisting of source files prime.c,
echo calc.c and io.c. Program prompts for numbers and tells whether
echo they are prime or not. End with 0 input.
echo.
pause

echo We have a makefile for doing the builds. First we clean the project by
echo issuing command:
echo.
echo nmake clean
echo.
pause
nmake clean
pause

echo.
echo Normally we would build the program by issuing command
echo.
echo nmake all
echo.
echo But we do the build with ctc by prepeding "ctc ctc-options" in front
echo of the make command, here as follows:
echo.
echo ctcwrap -v -i mti nmake all
echo.
echo We use ctc-options -v (verbose, for learning what ctc does internally at
echo each compile and link command) and -i mti (instrument for multicondition
echo coverage and for inclusive timing). 
pause

echo.
call ctcwrap -v -i mti nmake all
echo.
pause

echo.
echo Now we have instrumented Prime.exe. At the instrumentation phase a symbolfile
echo (MON.sym) was created, see
dir MON.sym
echo.
echo Now we run the program with some input.
pause

echo prime.exe
echo 1 > demo.tmp
echo 23 >> demo.tmp
echo 666 >> demo.tmp
echo 100434334 >> demo.tmp
echo 16 >> demo.tmp
echo 32 >> demo.tmp
echo 3782098 >> demo.tmp
echo 223 >> demo.tmp
echo 3 >> demo.tmp
echo 0 >> demo.tmp

prime.exe < demo.tmp
del demo.tmp > nul
echo.
pause

echo.
echo In the test run a datafile (MON.dat) was created, see
dir MON.dat
echo.
pause

echo.
echo Now see what kind of code coverage we got on this program. We take
echo Execution Profile Listing to stdout with command:
echo.
echo ctcpost MON.sym MON.dat -p - "|" more
echo.
pause
ctcpost MON.sym MON.dat -p - | more
echo.
pause.

echo.
echo We can take the same listing to a file and then convert it to HTML
echo form with commands:
echo.
echo ctcpost MON.sym MON.dat -p profile.txt
echo ctc2html -i profile.txt -nsb
echo.
pause
ctcpost MON.sym MON.dat -p profile.txt
call ctc2html -i profile.txt -nsb
echo.
echo Some CTCHTML\*.html files got born. Start your browser from file
echo CTCHTML\index.html for seeing the HTML representation.
echo.
pause

echo.
echo The code was instrumented also for timing. Lets see how the
echo Execution Time Listing looks. We use command:
echo.
echo ctcpost MON.sym MON.dat -t - "|" more
echo.
pause
ctcpost MON.sym MON.dat -t - | more
echo.
pause

echo.
echo You may want to play with this example by your own. Instrument this with
echo different instrumentation options, run the program multiple times with
echo different input and see if you get the coverage TER%% to grow, etc.
echo.
echo ---End of demo---
