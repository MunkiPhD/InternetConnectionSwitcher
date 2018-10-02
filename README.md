# InternetConnectionSwitcher
Quick switch between a hardwired connection and a wireless connection at the adapter level. This use case for this stupidly simply BAT script was to switch between the open Wifi connection and the secure Ethernet connection.

### README ###
This script is intended to switch between the hardwired connection and the wifi connection, in order to avoid having to plug/unplug cables or connect/disconnect to the VPN. Too much time is spent doing so!

### ASSUMPTIONS ###

- You already have the Wireless network connection saved on your PC
- You have a hardwired connection named Ethernet. If not, simply change the name in the .bat
- You have admin privileges on your machine

### Setup: ###
First thing you need to do is setup the names for the connections. In most cases, the information that is already set will work for you, but in case it doesnt, perform the following steps:
	
	1. click on the windows key
	2. without clicking on anything, type "cmd" and hit enter
	3. This should open the windows command prompt. In the command prompt, type the following: netsh interface show interface
	4. This will display a list of network interfaces. You will need to use the "Interface Name" as you see it there
	5. Copy that information to the variables below in the VARIABLES section

### Execution: ###
In order for this script to work correctly, you must right click and "Run as Administrator." One trick you can do is to create a shortcut to the .bat, and place it on your desktop. Then right click on that shortcut > Properties. There you can assign a shortcut key that *should* trigger from wherever you are. Windows is finicky... so... 

**TIP:** Sometimes when switching to the wifi, the script will hang because the network is waiting for authentication. Click on the wifi symbol in the bottom right of your taskbar and that will open the domain login popup. Once you enter your LDAP username and password the computer should connect to the wireless and the script will continue.

**TIP:** Switching connections and actually connecting to the internet can take a few seconds sometimes. Don't immediately assume that it's broken! Check for a warning sign or error symbol in the taskbar (bottom right)
