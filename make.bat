@echo off
rem ----------------------------------------------------------------------------
rem  CHC v0.2 * Chocking coil sizing application
rem  Copyright (C) 2012-2016 Pozsar Zsolt <pozsarzs@gmail.com>
rem  make.bat
rem  Utility for build/install/uninstall application on Windows
rem ----------------------------------------------------------------------------

rem - directories
set APPDIR=C:\Program Files\
set LAZDIR=C:\Lazarus\

rem - variables 
set ARCH=i386
set NAME=chc
set OS=win32
set VERSION=

rem - compiler parameters
set FPFLAG=-TWin32 -MObjFPC -Scgi -O1 -ve -Fu%LAZDIR%/lcl/units/%ARCH%-%OS%
           -Fu%LAZDIR%/lcl/units/%ARCH%-%OS% \
           -Fu%LAZDIR%/components/lazutils/lib/%ARCH%-%OS% \
           -Fu. -Fu.\lib\%ARCH%-%OS% -FE.\lib\%ARCH%-%OS% -dLCL -dLCLgtk2


rem - check parameters


rem - build source
:build

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
