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
echo.




echo.
echo                                           卐
echo =======================================================================================
echo =======================================================================================
echo.
echo     ██████╗  ██████╗   █████╗  ██████╗         ███████╗ █████╗ ██╗     ██╗     
echo    ██╔════╝  ██╔══██╗ ██╔══██╗ ╚════██╗        ██╔════╝██╔══██╗██║     ██║     
echo    ███████╗  ██████╔╝ ╚██████║  █████╔╝ █████╗ █████╗  ███████║██║     ██║     
echo    ██╔═══██╗ ██╔══██╗  ╚═══██║  ██╔═══╝ ╚════╝ ██╔══╝  ██╔══██╗██║     ██║     
echo    ╚██████╔╝  ██████╔╝  █████╔╝ ███████╗       ██║     ██║  ██║███████╗███████╗
echo     ╚═════╝   ╚═════╝   ╚════╝  ╚══════╝       ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝
echo.
echo =======================================================================================
echo =======================================================================================

echo ---------------------------------------------------------------------------------------
                              echo         6B92-FALL
echo ---------------------------------------------------------------------------------------
echo.
echo      [!] 
timeout /t 20 /nobreak

echo.
echo [+] 1. Repairing System Image (DISM)...
dism /online /cleanup-image /restorehealth 

echo [+] 2. Scanning System Files (SFC)...
sfc /scannow 

echo [+] 3. Cleaning All Temporary Files...
del /q /f /s %temp%\* 
del /q /f /s C:\Windows\Temp\* 
del /q /f /s C:\Windows\Prefetch\* 

echo [+] 4. Cleaning Windows Update Cache...
net stop wuauserv >nul 2>&1 
del /q /s /f C:\Windows\SoftwareDistribution\Download\* 
net start wuauserv >nul 2>&1 

echo [+] 5. Refreshing Internet (DNS Flush)...
ipconfig /flushdns 

echo [+] 6. Optimizing M.2 Drive (TRIM)...
defrag C: /o 

echo [+] 7. Emptying Recycle Bin...
rd /s /q %systemdrive%\$Recycle.Bin 

echo.
echo =======================================================================
echo      SUCCESS! Your System is now 6B92-FALL Certified (Optimized)
echo =======================================================================
pause
