@echo off
:: Color menu
:main
cls
echo Color Menu
echo The current color is %col%.
echo A) Change color
echo B) Restore default color
echo C) Return to menu
if [%menu%]==[] goto skipReset
set "menu="
:skipReset
set /p menu="What is your selection? "
if [%menu%]==[] goto invalid
if /i %menu% == A goto changeCol
if /i %menu% == B goto resetCol
if /i %menu% == C goto:eof
:invalid
echo Error: Invalid selection.
pause
goto main
:changeCol
echo Color values:
echo 0 = Black ^| 8 = Gray
echo 1 = Blue ^| 9 = Light Blue
echo 2 = Green ^| A = Light Green
echo 3 = Aqua ^| B = Light Aqua
echo 4 = Red ^| C = Light Red
echo 5 = Purple ^| D = Light Purple
echo 6 = Yellow ^| E = Light Yellow
echo 7 = White ^| F = Bright White
if [%col1%]==[] goto skipResetCol1
set "col1="
:skipResetCol1
set /p col1="Enter background color: "
if [%col2%]==[] goto skipResetCol2
set "col2="
:skipResetCol2
set /p col2="Enter foreground color: "
setlocal
set colstr=%col1%%col2%
set collen=0
call data\util.bat strlen colstr collen
if %collen% GTR 2 goto error_tooLong
endlocal
if %col1%==%col2% goto error_sameCol
setlocal
set coltemp=%col1%%col2%
set hex=0
call data\util.bat isHex %coltemp% hex
if %hex% EQU 0 goto error_notHex
endlocal
set col=%col1%%col2%
color %col%
goto main
:error_tooLong
echo Error: Please type one character for each color.
pause
goto main
:error_sameCol
echo Error: Background and foreground colors cannot be the same.
pause
goto main
:error_notHex
echo Error: Please type hexadecimal values (0-9 and A-F) only.
pause
goto main
:resetCol
echo Are you sure you want to reset the color?
if [%rcol%]==[] goto skipResetRCol
set "rcol="
:skipResetRCol
set /p rcol="[Y/N] "
if /i %rcol% == Y (goto resetColFunc) else (goto main)
:resetColFunc
set col=9F
color %col%
goto main