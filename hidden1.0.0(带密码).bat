@ECHO OFF
REM 
chcp 65001
CLS

set name=起一个固定的文件夹名称
set password=定义一个固定解锁的密码

title Folder %name%
if EXIST "Locker" goto UNLOCK
if NOT EXIST %name% goto MDLOCKER

:LOCK
ren %name% "Locker"
attrib +h +s "Locker"
echo Folder locked
goto End

:UNLOCK
echo 输入密码
set /p "pass=>"
if NOT %pass%==%password% goto FAIL
attrib -h -s "Locker"
ren "Locker" %name%
echo Folder Unlocked successfully
goto End

:FAIL
echo Invalid password
pause
goto end

:MDLOCKER
md %name%
echo %name% created successfully
goto End
:End