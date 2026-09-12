@echo off
call "C:\Program Files (x86)\Embarcadero\Studio\37.0\bin\rsvars.bat"
if errorlevel 1 exit /b %errorlevel%
cd /d "D:\Projects\MyProjects\wms\sources"
msbuild SWN.dproj /p:Config=Release /p:Platform=Win32 /nologo /v:minimal
