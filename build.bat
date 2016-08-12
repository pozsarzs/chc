@echo off
rem ----------------------------------------------------------------------------
rem  CHC v0.2 * Chocking coil sizing application
rem  Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>
rem  build.bat
rem  Utility for build/install/uninstall application on Windows
rem ----------------------------------------------------------------------------

rem - variables 
set PPC=c:\lazarus\fpc\2.6.4\bin\i386-win32\ppc386.exe
set LAZ=c:\lazarus\

set NAME=CHC
set /p VERSION=<documents\VERSION
set OS=win32
set ARCH=i386

rem - check parameters
echo %NAME% v%VERSION% - builder/installer utility
if "%~1" == "" goto build
if "%~1" == "clean" goto clean
if "%~1" == "install" goto install
if "%~1" == "uninstall" goto uninstall
if "%~1" == "/?" goto usage
:usage
echo Usage: build.bat [clean ^| install ^| uninstall]
echo.
echo        build.bat             compile source code
echo        build.bat clean       clean source code
echo        build.bat install     install application
echo        build.bat uninstall   uninstall application
echo.
goto end

rem - build source
:build
echo Check FreePascal compiler: %PPC%
if not exist "%PPC%" ( set /p PPC=Enter compiler with full path: )
if not exist "%PPC%" ( echo Error: compiler not found! & goto end )

echo Check Lazarus IDE folder: %LAZ%
if not exist "%LAZ%" ( set /p LAZ=Enter component units folder: )
if not exist "%LAZ%" ( echo Error: Folder not found! & goto end )

set FPFLAG1=-TWin32 -MObjFPC -Scgi -O1 -ve -WG
set FPFLAG2=-Fu%LAZ%\lcl\units\%ARCH%-%OS% -Fu%LAZ%\lcl\units\%ARCH%-%OS%\%OS%
set FPFLAG3=-Fu%LAZ%\components\lazutils\lib\%ARCH%-%OS% -Fu. -Fu.\lib\%ARCH%-%OS%
set FPFLAG4=-FE.\lib\%ARCH%-%OS% -dLCL -dLCLwin32

cd source
%PPC% %FPFLAG1% %FPFLAG2% %FPFLAG3% %FPFLAG4% chc.lpr
echo.
if errorlevel 0 echo Run 'build.bat install' to install application.
cd ..
goto end

rem - clean source
:clean

goto end

rem - install application
:install
set INSTDIR=%APPDIR%\%NAME%
md %INSTDIR%
rem if not %ERRORLEVEL%=="0" goto error  
md %INSTDIR%\documents
md %INSTDIR%\documents\hu
md %INSTDIR%\languages
copy documents\AUTHORS %INSTDIR%\documents\authors.txt
copy documents\COPYING %INSTDIR%\documents\copying.txt
copy documents\README %INSTDIR%\documents\readme.txt
copy documents\VERSION %INSTDIR%\documents\version.txt
copy documents\hu\README %INSTDIR%\documents\hu\readme.txt
copy languages\*.* %INSTDIR%\languages\
copy README %INSTDIR%\readme.txt 
copy source\lib\%ARCH%-%OS%\chc.exe %INSTDIR%\chc.exe 
goto end

rem - uninstall application
:uninstall


goto end

rem - error message
:error
echo An error occured!
pause

:end
