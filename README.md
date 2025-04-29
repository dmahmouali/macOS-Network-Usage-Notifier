# 📶 macOS Network Usage Notifier

This script monitors network data usage per process on macOS using `nettop`, and notifies you via native macOS notifications if any process exceeds a specified data threshold (default: **5 GB**).

---

## 🛠 Features

- Monitors all active processes and their network usage
- Sends a visible **macOS notification** using `terminal-notifier`
- Configurable threshold (in bytes)
- Easy to run manually or schedule periodically via `cron` or `launchd`

---

## 🔧 Requirements

- macOS (tested on Monterey and Ventura)
- [`terminal-notifier`](https://github.com/julienXX/terminal-notifier)
- Bash (macOS default is fine)

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/dmahmouali/macOS-Network-Usage-Notifier.git
cd macOS-Network-Usage-Notifier
```

### 2. Make the script executable

```bash
chmod +x network_usage_notifier.sh
```

### 3. Install terminal-notifier

```bash
brew install terminal-notifier
```

---

## 🔔 Enable Notifications (macOS Settings)

To receive notifications, ensure terminal-notifier is allowed in System Settings:

System Settings → Notifications → terminal-notifier

- ✅ Enable Allow Notifications
- 📢 Choose Banners or Alerts
- ✅ Enable Show in Notification Center and Play sound for notification

---

## ⚙️ Configuring the Threshold

Open `network_usage_notifier.sh` in a text editor. Near the top:

```bash
# Threshold in bytes (default: 5 GB)
THRESHOLD=$((5 * 1024 * 1024 * 1024))
```

You can change 5 to any value you want (e.g., for 1 GB):

```bash
THRESHOLD=$((1 * 1024 * 1024 * 1024))
```

---

## ⏱ Scheduling Periodic Checks

### Using cron

Run `crontab -e` and add:

```bash
*/10 * * * * /path/to/network_usage_notifier.sh
```

This runs the script every 10 minutes.

### Using launchd (macOS-native)

Ask in issues or check the launchd example in the extras/ folder.

---

## 🧪 Example Output

```
Process Microsoft Teams.968 transferred over 5 GB
```

You'll also get a macOS popup.

---

## 📄 License

MIT

---

## 🤝 Contributing

PRs are welcome! Please ensure compatibility with default macOS bash and limit external dependencies.