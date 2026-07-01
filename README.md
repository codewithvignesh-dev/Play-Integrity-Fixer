# Play Integrity Fixer

A Magisk module that automatically keeps your Play Integrity configuration up to date by checking for the latest Keybox and PIF updates.

## Features

- 🔄 Automatic update checking
- 🔔 Notification when a new update is available
- ⚡ One-tap update using the Magisk **Action** button
- 🔑 Automatic Keybox update detection
- 📱 Automatic PIF update detection
- 🛡️ Tricky Store integration
- 🚀 Lightweight and battery friendly

## Requirements

- Android 10+
- Magisk v28.0 or newer
- Tricky Store installed
- Internet connection for update checks

## How it Works

1. Periodically checks for the latest Play Integrity resources.
2. Compares the installed Keybox with the latest available version.
3. Notifies you only when an update is available.
4. Install the update using the Magisk Action button.

## Installation

1. Download the latest release.
2. Flash the ZIP using Magisk.
3. Reboot your device.
4. Enjoy automatic update notifications.

## Action Button

The Magisk **Action** button performs the update process by:

- Downloading the latest Keybox
- Downloading the latest PIF (if available)
- Validating downloaded files
- Installing them safely
- Restarting required services

## Directory Structure

```
config/
scripts/
system/
module.prop
service.sh
action.sh
```

## Credits

- osm0sis
- Tricky Store
- Magisk
- Android Open Source Project

## Disclaimer

This project is provided for educational and research purposes.

Use it at your own responsibility.

Google may change Play Integrity behaviour at any time.