@ECHO OFF
set name=WorkspaceTo
REM 
chcp 65001
CLS
title Folder %name%
if EXIST "Locker" goto UNLOCK
if NOT EXIST %name% goto MDLOCKER

:LOCK
ren %name% "Locker"
attrib +h +s "Locker"
echo Folder locked
goto End

:UNLOCK
attrib -h -s "Locker"
ren "Locker" %name%
echo Folder Unlocked successfully
goto End

:MDLOCKER
md %name%
echo %name% created successfully
goto End
:End