@ECHO OFF
chcp 936

::主隐藏文件夹的路径
set myDirPath=%USERPROFILE%\Desktop
::例如设置桌面为隐藏文件夹的路径:set myDirPath=%USERPROFILE%\Desktop
::主隐藏文件夹的名称
set myDirName=MyWorkspace
::解锁密码
set password=hidden

if EXIST "%myDirPath%\Locker" goto UNLOCK
if NOT EXIST %myDirPath%\%myDirName% goto MDLOCKER

:CONFIRM
echo 输入数字对应指令(直接回车默认是1的指令, 输入空格为关闭):
echo 1: 把宝贝藏起来
echo 2: 为快速启动创建快捷方式
echo 3: 为隐藏文件创建快捷方式
set /p "cho=>"
if defined cho (
	goto SELECT
) else goto LOCK

:SELECT
set isStart=0
if %cho%==1 goto LOCK
if %cho%==2 (
	set isStart=1
	goto CreateShortcut)
if %cho%==3 (
	set isStart=0
	goto CreateShortcut)
if %cho%==" " exit
echo 输入的数字无法解析命令
pause
goto CONFIRM

:LOCK
setlocal enabledelayedexpansion 
set hiddenPath=!myDirPath!\!myDirName!\Hidden
for /f %%i in ('dir /a/b !hiddenPath!') do (
set subdir=%%i
if /i !subdir:~-3!==lnk (
for /f "delims=" %%a in ('find /i ":" !hiddenPath!\!subdir! ^| findstr /i "^[a-z]:"') do pushd %%~dpa
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
set hiddenPath=!myDirPath!\!myDirName!\Hidden
for /f %%i in ('dir /a/b !hiddenPath!') do (
set subdir=%%i
if /i !subdir:~-3!==lnk (
for /f "delims=" %%a in ('find /i ":" !hiddenPath!\!subdir! ^| findstr /i "^[a-z]:"') do pushd %%~dpa
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
goto End

:MDLOCKER
md %myDirPath%\%myDirName%
echo %myDirPath%\%myDirName% created successfully
goto End


:CreateShortcut

::设置程序的工作路径，一般为程序主目录，此项若留空，脚本将自行分析路径
set WorkDir=%cd%
echo 请输入文件的完整路径
set /p "Program=>"
:intercept
if "%Program:~0,1%"==" " set Program=%Program:~1%&goto intercept
for /F "usebackq delims=[]" %%I in (`echo %Program%`) do set LnkName=%%~nxI
if not defined WorkDir call:GetWorkDir "%Program%"
(echo Set WshShell=CreateObject("WScript.Shell"^)
echo strDesKtop=WshShell.SpecialFolders("Desktop"^)
echo Set oShellLink=WshShell.CreateShortcut(strDesKtop^&"\%LnkName%.lnk"^)
echo oShellLink.TargetPath="%Program%"
echo oShellLink.WorkingDirectory="%WorkDir%"
echo oShellLink.WindowStyle=1
echo oShellLink.Description=""
echo oShellLink.Save)>makelnk.vbs
makelnk.vbs
del /f /q makelnk.vbs
if %isStart%==1 goto SPEEDSTART
if %isStart%==0 goto HIDDENFILE
:SPEEDSTART
set myLinkPath=%myDirPath%\%myDirName%\Link
if NOT EXIST %myLinkPath% md %myLinkPath%
move %USERPROFILE%\Desktop\%LnkName%.lnk  %myLinkPath%\%LnkName%.lnk
start %myLinkPath%
goto End
:HIDDENFILE
set myLinkPath=%myDirPath%\%myDirName%\Hidden
if NOT EXIST %myLinkPath% md %myLinkPath%
move %USERPROFILE%\Desktop\%LnkName%.lnk  %myLinkPath%\%LnkName%.lnk
start %myLinkPath%
goto End

goto :eof
:GetWorkDir
set WorkDir=%~dp1
set WorkDir=%WorkDir:~,-1%
goto :eof



:End
