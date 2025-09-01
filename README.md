# 🔐 Linux Authentication Log Monitor

A lightweight Bash script that scans `/var/log/auth.log` for failed login attempts, identifies top offending IP addresses and usernames, logs the data locally, and runs automatically via cron.

## 📌 Features

- Detects failed login attempts by parsing `/var/log/auth.log`
- Extracts top 5 offending IP and username pairs
- Displays recent failed login attempts with timestamps
- Logs results to a local file: `/home/mohamed/login_monitor.log`
- Color-coded terminal output (Red for alerts, Green for OK)
- Self-installs a cron job to run hourly (configurable)

---

## 🖥️ Demo Output

```bash
--- Authentication Log Monitor ---
Warning: Found 41 failed login attempts.

Top 5 offending IP & username pairs:
      6 127.0.0.1 unknown

Most Recent Failed Login Attempts with Timestamps:
Sep  1 10:09:48 simo sshd-session[52592]: PAM 2 more authentication failures; rhost=127.0.0.1
...
