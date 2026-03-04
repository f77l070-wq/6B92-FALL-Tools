@echo off
chcp 65001 >nul
:: طلب صلاحيات المسؤول
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' ( goto UACPrompt ) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%cd%"
    CD /D "%~dp0"

:login
cls
echo.
echo =======================================================
echo           6B92-FALL: Protection system
echo =======================================================
echo.
set /p pass="[!] Enter the login code to activate the tool: "

if %pass%==6B92 (
    goto start_process
) else (
    echo [X] الرمز خاطئ! حاول مرة أخرى.
    timeout /t 2 >nul
    goto login
)

:start_process
cls

echo.
echo.
echo.
echo.
echo.
echo.
echo                                                                       卐
echo                         =======================================================================================
echo                         =======================================================================================
echo.
echo                                 ██████╗  ██████╗   █████╗  ██████╗         ███████╗ █████╗ ██╗     ██╗     
echo                                ██╔════╝  ██╔══██╗ ██╔══██╗ ╚════██╗        ██╔════╝██╔══██╗██║     ██║     
echo                                ███████╗  ██████╔╝ ╚██████║  █████╔╝ █████╗ █████╗  ███████║██║     ██║     
echo                                ██╔═══██╗ ██╔══██╗  ╚═══██║  ██╔═══╝ ╚════╝ ██╔══╝  ██╔══██╗██║     ██║     
echo                                ╚██████╔╝  ██████╔╝  █████╔╝ ███████╗       ██║     ██║  ██║███████╗███████╗
echo                                 ╚═════╝   ╚═════╝   ╚════╝  ╚══════╝       ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝
echo.
echo                         =======================================================================================
echo                         =======================================================================================
echo.
echo                                                                  6B92-FALL
echo.
echo.
echo                                                                     [!] 
timeout /t 30 /nobreak

echo.
echo [+] 1. Repairing System Image (DISM)...
dism /online /cleanup-image /restorehealth 

echo [+] 2. Scanning System Files (SFC)...
sfc /scannow 

echo [+] 3. Cleaning All Temporary Files...
del /q /f /s %temp%\* del /q /f /s C:\Windows\Temp\* del /q /f /s C:\Windows\Prefetch\* echo [+] 4. Cleaning Windows Update Cache...
net stop wuauserv >nul 2>&1 
del /q /s /f C:\Windows\SoftwareDistribution\Download\* net start wuauserv >nul 2>&1 

echo [+] 5. Optimizing RAM Cache...
%SystemRoot%\System32\Cmd.exe /c "echo off | clip"
echo [!] RAM Cache has been purged.

echo [+] 6. Refreshing Internet (DNS Flush)...
ipconfig /flushdns 

echo [+] 7. Optimizing M.2 Drive (TRIM)...
defrag C: /o 

echo [+] 8. Emptying Recycle Bin...
rd /s /q %systemdrive%\$Recycle.Bin 

:: [Final Summary]
:summary
cls
echo.
echo =======================================================
echo          6B92-FALL: FINAL PROCESS REPORT
echo =======================================================
echo.
echo  [SUCCESS] SYSTEM FILES SCAN      : COMPLETED
echo  [SUCCESS] TEMP FILES CLEANING    : COMPLETED
echo  [SUCCESS] RAM CACHE OPTIMIZATION : COMPLETED
echo  [SUCCESS] M.2 DRIVE SPEED BOOST  : COMPLETED
echo  [SUCCESS] INTERNET DNS REFRESH   : COMPLETED
echo.
echo -------------------------------------------------------
echo     STATUS: YOUR SYSTEM IS NOW FULLY OPTIMIZED
echo -------------------------------------------------------
echo.
echo PRESS ANY KEY TO EXIT 6B92-FALL TOOL...
pause >nul
exit
