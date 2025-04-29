#!/bin/bash

# Threshold in bytes (5 GB)
THRESHOLD=$((5 * 1024 * 1024 * 1024))
TMPFILE="/tmp/macos_net_usage.csv"

# Capture nettop snapshot
nettop -P -x -l 1 > /tmp/nettop_snapshot.txt

# Loop through each line of the nettop output
while IFS= read -r line; do
    proc=$(echo "$line" | awk '{print $1}')
    in_bytes=$(echo "$line" | awk '{print $(NF-4)}')
    out_bytes=$(echo "$line" | awk '{print $(NF-3)}')

    # Skip header or empty entries
    [[ "$proc" == time* ]] && continue
    [[ -z "$proc" ]] && continue

    total=$((in_bytes + out_bytes))

    # Get previously recorded value
    old_total=$(grep "^$proc," "$TMPFILE" 2>/dev/null | cut -d',' -f2)
    old_total=${old_total:-0}

    delta=$((total - old_total))

    if [ "$delta" -gt "$THRESHOLD" ]; then
        terminal-notifier -title "Network Alert" -message "Process $proc transferred over 5 GB"
    fi

    # Update value in temp file
    grep -v "^$proc," "$TMPFILE" 2>/dev/null > "${TMPFILE}.tmp"
    echo "$proc,$total" >> "${TMPFILE}.tmp"
    mv "${TMPFILE}.tmp" "$TMPFILE"

done < /tmp/nettop_snapshot.txt 