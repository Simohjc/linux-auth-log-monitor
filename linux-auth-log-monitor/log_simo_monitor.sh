#!/bin/bash
# ---------------------------------------
# Authentication Failure Monitor Script
# ---------------------------------------
# ➤ Log File: /var/log/login_monitor.log
# ➤ Script Path: /home/mohamed/login_monitor.sh
# ➤ Runs Hourly via Cron: 0 * * * * /home/mohamed/login_monitor.sh
# ---------------------------------------

# Authentication Failure Monitor Script
log_file="/var/log/auth.log"
failure_count=$(sudo grep -c "authentication failure" "$log_file")
threshold=5
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
    echo "--- Authentication Log Monitor ---"

if [ "$failure_count" -gt "$threshold" ]; then
    echo -e "${RED}Warning: Found $failure_count failed login attempts.${NC}"

    echo -e "\nTop 5 offending IP & username pairs:"
sudo grep "authentication failure" "$log_file" | awk '{
    ip=""; user="unknown";
    for (i=1; i<=NF; i++) {
        if ($i ~ /rhost=/) { split($i, a, "="); ip=a[2]; }
        if ($i ~ /user=/ || $i ~ /ruser=/)  {
            split($i, b, "=");
            if (b[2] != "") user=b[2];
        }
    }
    if (ip != "")
        print ip, user;
}' | sort | uniq -c | sort -nr | head -5
    echo -e "\nMost Recent Failed Login Attempts with Timestamps:"
    sudo grep "authentication failure" "$log_file" | grep sshd | tail -n 5
else
    echo -e "${GREEN}OK: No significant failed login attempts found.${NC}"
fi
    echo "$(date): Found $failure_count failed login attempts" >> /home/mohamed/login_monitor.log

# To run this script hourly via cron, add:
# --- Optional: Automatically install cron job ---
cron_entry="0 * * * * /home/mohamed/to/login_monitor.sh"
(crontab -l 2>/dev/null | grep -Fxq "$cron_entry") || (
    (crontab -l 2>/dev/null; echo "$cron_entry") | crontab -
    echo "Cron job installed to run this script hourly."
)

