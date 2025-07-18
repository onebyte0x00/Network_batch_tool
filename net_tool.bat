@echo off
:menu
cls
echo Network Adapter Management Tool
echo ------------------------------
echo 1. List all network adapters
echo 2. Enable/Disable adapter
echo 3. Show WiFi networks
echo 4. Connect to WiFi
echo 5. Change IP configuration
echo 6. Change DNS servers
echo 7. Export WiFi profiles
echo 8. Exit
echo ------------------------------
set /p choice="Enter your choice: "

if "%choice%"=="1" goto list
if "%choice%"=="2" goto toggle
if "%choice%"=="3" goto scan
if "%choice%"=="4" goto connect
if "%choice%"=="5" goto ipconfig
if "%choice%"=="6" goto dns
if "%choice%"=="7" goto export
if "%choice%"=="8" exit

:list
netsh interface show interface
pause
goto menu

:toggle
netsh interface show interface
set /p adapter="Enter adapter name: "
set /p action="Enable or Disable (E/D)? "
if /i "%action%"=="D" netsh interface set interface "%adapter%" disable
if /i "%action%"=="E" netsh interface set interface "%adapter%" enable
pause
goto menu

:scan
netsh wlan show networks
pause
goto menu

:connect
set /p ssid="Enter SSID: "
set /p pass="Enter password: "
netsh wlan connect name="%ssid%" ssid="%ssid%" interface="Wi-Fi"
pause
goto menu

:ipconfig
set /p adapter="Enter adapter name: "
set /p ip="Enter IP address: "
set /p mask="Enter subnet mask: "
set /p gateway="Enter gateway: "
netsh interface ip set address name="%adapter%" static %ip% %mask% %gateway% 1
pause
goto menu

:dns
set /p adapter="Enter adapter name: "
set /p dns1="Enter primary DNS: "
set /p dns2="Enter alternate DNS: "
netsh interface ip set dns name="%adapter%" static %dns1% primary
netsh interface ip add dns name="%adapter%" %dns2% index=2
pause
goto menu

:export
set /p folder="Enter export folder: "
netsh wlan export profile name=* folder="%folder%" key=clear
pause
goto menu
