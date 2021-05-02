@ECHO OFF
REM 
chcp 65001
CLS

set myDirPath=设置固定的隐藏文件所在路径(绝对路径)
rem 例如设置桌面为隐藏文件夹的路径:set myDirPath=%USERPROFILE%\Desktop
set myDirName=设置固定的隐藏文件夹名称
set password=设置解锁密码

title Folder %myDirPath%\%myDirName%
if EXIST "%myDirPath%\Locker" goto UNLOCK
if NOT EXIST %myDirPath%\%myDirName% goto MDLOCKER

:LOCK
setlocal enabledelayedexpansion 
for /f %%i in ('dir /a/b !myDirPath!\!myDirName!') do (
set subdir=%%i
if /i !subdir:~-3!==lnk (
for /f "delims=" %%a in ('find /i ":" !myDirPath!\!myDirName!\!subdir! ^| findstr /i "^[a-z]:"') do pushd %%~dpa
set filePath=!cd!\!subdir:~0,-4!
echo !filePath!
attrib +h +s !filePath!
)
)
setlocal disabledelayedexpansion 
ren %myDirPath%\%myDirName% "Locker"
attrib +h +s %myDirPath%\"Locker"
echo Folder locked
goto End

:UNLOCK
echo 输入密码
set /p "pass=>"
if NOT %pass%==%password% goto FAIL
attrib -h -s %myDirPath%\"Locker"
ren %myDirPath%\"Locker" %myDirName%
setlocal enabledelayedexpansion 
for /f %%i in ('dir /a/b !myDirPath!\!myDirName!') do (
set subdir=%%i
if /i !subdir:~-3!==lnk (
for /f "delims=" %%a in ('find /i ":" !myDirPath!\!myDirName!\!subdir! ^| findstr /i "^[a-z]:"') do pushd %%~dpa
set filePath=!cd!\!subdir:~0,-4!
attrib -h -s !filePath!
)
)
setlocal disabledelayedexpansion 
echo Folder Unlocked successfully
goto End

:FAIL
echo Invalid password
pause
goto end

:MDLOCKER
md %myDirPath%\%myDirName%
echo %myDirPath%\%myDirName% created successfully
goto End
:End