:: ==================== README ====================
::	This script is intended to switch between the hardwired connection and the wifi connection, in order to avoid having to plug/unplug
::		cables or connect/disconnect to the VPN. Too much time is spent doing so!
::
::	Setup:
::		First thing you need to do is setup the names for the connections. In most cases, the information that is already
::			set will work for you, but in case it doesnt, perform the following steps:
::			1. click on the windows key
::			2. without clicking on anything, type "cmd" and hit enter
::			3. This should open the windows command prompt. In the command prompt, type the following: netsh interface show interface
::			4. This will display a list of network interfaces. You will need to use the "Interface Name" as you see it there
::			5. Copy that information to the variables below in the VARIABLES section
::	
::	Execution:
::		In order for this script to work correctly, you must right click and "Run as Administrator"
::
::	TIP:
::		Sometimes when switching to the wifi, the script will hang because the network is waiting for authentication. Click on the wifi
::		symbol in the bottom right of your taskbar and that will open the domain login popup. Once you enter your LDAP username and password
::		the computer should connect to the wireless and the script will continue.
::
::	TIP: 
::		Switching connections and actually connecting to the internet can take a few seconds sometimes. Don't immediately assume that it's 
::		broken! Check for a warning sign or error symbol in the taskbar (bottom right)
::


:: ==================== VARIABLES ====================
:: // The default values are the ethernet for the hardwired and the 5g network that is open for the wifi
SET WIFINAME="Wi-Fi"
SET ETHERNETNAME="Ethernet"
SET WirelessNetwork="<<insert your wireless network name here>>"



ECHO OFF
ECHO ================== Available Network InterfacesICS ==================
netsh interface show interface

:: // This is a quick check to see if the WiFi is connected. If it is, we use that as our flag to determine what to switch
echo checking for connection to %ETHERNETNAME%...
netsh interface show interface name=%ETHERNETNAME% | find "Connect state" | find "Connected" >nul || goto :setEthernet
echo %ETHERNETNAME% is connected, switching to %WIFINAME%...
goto :setWifi


================ Set Wifi ================ 
:: // This sets the connection to the WiFi connection by name that you setup above
:setWifi
netsh interface set interface %ETHERNETNAME% admin=disable
netsh interface set interface %WIFINAME% admin=enable
SET CONNECTION_NAME=%WIFINAME%
goto :connection_check


================ Set Ethernet ================ 
:: // This sets the connection to the hardwided connection by name that you setup above
:setEthernet
netsh interface set interface %WIFINAME% admin=disable
netsh interface set interface %ETHERNETNAME% admin=enable
SET CONNECTION_NAME=%ETHERNETNAME%
goto :connection_check


:: // connection_check is for checking whether we are connected
:connection_check
:check_loop
timeout 2
echo Checking for connection to %CONNECTION_NAME%...
netsh interface show interface name=%CONNECTION_NAME% | find "Connect state" | find "Connected" >nul || goto :check_loop
echo Not connected to %CONNECTION_NAME% connection.
goto :end


:end
netsh interface show interface