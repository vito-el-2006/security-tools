#!/bin/sh

# Scanning for new WiFi networks
scan()
{
	output_file="$1"
	nmcli -t -f SSID,BSSID,SECURITY dev wifi | awk '{
		n = split($0, a, ":")
		security = a[n]
		bssid = a[n-6] ":" a[n-5] ":" a[n-4] ":" a[n-3] ":" a[n-2] ":" a[n-1]
		ssid = a[1]
		for (i = 2; i <= n-7; i++)
			ssid = ssid ":" a[i]
		gsub(/\\:/, ":", bssid)
		printf "%s___|___%s___|___%s___|___\n", bssid, ssid, security
	}' >> "$output_file"
}

# Cleaning output file
clean()
{
	output_file=$1
	awk -F'|' '!seen[$1]++' "$output_file" > "$output_file.tmp" && mv "$output_file.tmp" "$output_file"
}

trap 'echo "Stopping scan and cleaning data..." ; clean "ScanResults"; exit $?' INT
echo "Starting scan..."
while true; do
	scan "ScanResults"
done
