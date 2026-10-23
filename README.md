# Posix-WiFi-Scanner

These scripts are POSIX compliant and due to that are not designed to be
ran on Windows devices.

There are two scripts, one is the network scanner itself and a script
deisgned to format the output of it. They are described below;

wifi-posix-scanner.sh:

	This script will find nearby WiFi networks using NMCLI (Network
Manager's CLI utility) and save them inside of a file named ScanResults.

wifi-posix-scan-formatter.sh:

	This script will format the ScanResults output (must be passed
as an argument) to this script, it uses Python3 to format the output in
two different ways. The first is a semi-human readable fassion that uses
a string to signify a BSSID and SSID from each other. The second is JSON
where the SSID is set as the key and the BSSID is set as the value.
