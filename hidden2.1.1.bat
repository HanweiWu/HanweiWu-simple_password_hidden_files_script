@ECHO OFF
chcp 936

::�������ļ��е�·��
set myDirPath=%USERPROFILE%\Desktop
::������������Ϊ�����ļ��е�·��:set myDirPath=%USERPROFILE%\Desktop
::�������ļ��е�����
set myDirName=MyWorkspace
::��������
set password=hidden

if EXIST "%myDirPath%\Locker" goto UNLOCK
if NOT EXIST %myDirPath%\%myDirName% goto MDLOCKER

:CONFIRM
echo �������ֶ�Ӧָ��(ֱ�ӻس�Ĭ����1��ָ��, ����ո�Ϊ�ر�):
echo 1: �ѱ���������
echo 2: Ϊ��������������ݷ�ʽ
echo 3: Ϊ�����ļ�������ݷ�ʽ
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
echo ����������޷���������
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
echo ��������
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

::���ó���Ĺ���·����һ��Ϊ������Ŀ¼�����������գ��ű������з���·��
set WorkDir=%cd%
echo �������ļ�������·��
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
