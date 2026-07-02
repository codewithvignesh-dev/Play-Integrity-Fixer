# Changelog

All notable changes to this project will be documented in this file.

## v1.2.0

### Added

- Added Magisk `updateJson` support for automatic module update detection.
- Added version-based notification tracking to prevent repeated notifications for the same Keybox version.
- Added persistent notification state using the existing configuration.

### Changed

- Fixed API requests to use the correct endpoint (`index.php`) instead of the download endpoint.
- Improved Action button workflow by using the last fetched `download_url`.
- Improved JSON parsing compatibility with Android/Toybox shell.
- Refined update detection and download workflow for better reliability.
- Enhanced module metadata and update compatibility.

### Fixed

- Fixed update checks failing due to incorrect API endpoint usage.
- Fixed Action update process not downloading the latest Keybox correctly.
- Fixed remote version parsing on Android.
- Fixed repeated notifications for the same Keybox version.
- Various reliability improvements and bug fixes.

---

## v1.1.0

### Added

- Automatic Keybox update detection.
- SHA-256 based Keybox comparison.
- Automatic update notifications.
- Improved download validation.

### Changed

- Removed separate hash tracking file.
- Compare directly against the installed Tricky Store Keybox.
- Improved update reliability.

### Fixed

- Improved download verification.
- Better error handling.
- General bug fixes.

---

## v1.0.0

### Initial Release

- Automatic Play Integrity update checker.
- Play Integrity Keybox update support.
- Magisk Action integration.
- Notification support.
- Background update service.
- Configurable update interval.
- Tricky Store integration.