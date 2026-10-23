#!/bin/sh

target_file=""
if [ $# -ne 1 ]; then
	echo "Please pass a single file to be used for moving and formatting."
	exit 1
fi
target_file=$1
echo "Formatting $target_file..."
current_date=$(date +"%A-%m-%d-%Y")
json_file="$current_date.scan.json"
cp "$target_file" "$current_date.scan"
python3 - "$current_date.scan" "$json_file" <<'PY'
import json
import sys
scan_file = sys.argv[1]
json_file = sys.argv[2]
networks = {}
with open(scan_file, "r") as file_handle:
	for line in file_handle.readlines():
		line = line.rstrip("\n")
		fields = line.split("___|___")
		if len(fields) < 3:
			continue
		bssid = fields[0]
		ssid = fields[1]
		if ssid == "":
			ssid = "Unknown"
		security = fields[2]
		if security == "":
			security = "None"
		networks.setdefault(ssid, []).append([
			bssid, security
		])
	file_handle.close()
with open(json_file, "w") as file_handle:
	json.dump(networks, file_handle, indent=4)
	file_handle.close()
PY
