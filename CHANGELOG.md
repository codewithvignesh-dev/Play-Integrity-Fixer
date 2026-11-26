# Changelog

All notable changes to this project will be documented in this file.

## v1.5.1

### Added

- Added numeric validation for the remote Keybox version.
- Added error reporting for invalid or missing version values.
- Added remote version logging for improved debugging.

### Changed

- Improved JSON-based remote version extraction in `updater.sh`.
- Replaced legacy version parsing with pattern-based extraction for better reliability.
- Improved compatibility with compact JSON API responses.

### Fixed

- Fixed incorrect remote version extraction from Keybox API responses.
- Fixed update checks failing due to malformed or invalid version values.
- Improved overall update checker stability and reliability.

---

## v1.5.0

### Added

- Added support for the new Flask-based Keybox API backend.
- Added compatibility with updated Keybox API response and download endpoints.
- Added server-side Keybox caching and automated refresh support.
- Added API health and availability checks.
- Added improved error handling for API connection failures and request timeouts.

### Changed

- Migrated Keybox API integration from the legacy PHP backend to the new Python Flask WSGI architecture.
- Improved Keybox update detection using server-side cached metadata.
- Optimized API request handling to reduce unnecessary upstream requests.
- Improved compatibility with cPanel-hosted Keybox API services.
- Enhanced Keybox download and update workflows for better reliability.
- Refined network timeout and retry behavior for improved stability.

### Fixed

- Fixed compatibility issues related to the legacy Keybox API implementation.
- Improved handling of HTTP 500 errors and server-side request timeouts.
- Reduced unnecessary network requests during temporary API outages.
- Improved Keybox update reliability under unstable network conditions.
- Various performance improvements, compatibility fixes, and stability enhancements.

---

## v1.4.0

### Added

- Added custom HTTP User-Agent support for Keybox API requests.
- Added consistent User-Agent identification across update checks and Keybox downloads.
- Added configurable connection and request timeouts for improved network reliability.
- Added automatic retry handling for failed HTTP requests.

### Changed

- Improved HTTP request compatibility with Cloudflare-protected API endpoints.
- Standardized HTTP request configuration across the update checker and Action workflow.
- Enhanced Keybox download reliability under unstable network conditions.
- Refined update completion notifications to accurately reflect download status.

### Fixed

- Fixed compatibility issues affecting automated requests to protected Keybox services.
- Improved handling of temporary connection failures and request timeouts.
- Reduced update failures caused by intermittent network connectivity.

---

## v1.3.0

### Added

- Added AutoPIF integration for automatic Play Integrity profile generation.
- Added automatic retrieval of the latest Pixel Beta device catalog.
- Added automatic retrieval of the latest Pixel Canary build metadata.
- Added automatic generation of minimal PIF profiles.
- Added automatic migration to an advanced custom PIF profile.
- Added profile metadata caching for improved generation efficiency.
- Added expiry date tracking for generated Canary profiles.
- Added support for automatic profile regeneration before profile expiry.
- Added Premium CLI interface with streamlined progress reporting.
- Added completion status reporting after successful profile generation.

### Changed

- Redesigned the entire CLI output with a consistent Premium CLI theme.
- Improved profile generation workflow and status reporting.
- Simplified migration output while preserving generated configuration files.
- Updated notification messages with clearer and more professional wording.
- Improved profile generation reliability and metadata handling.

### Fixed

- Fixed profile migration compatibility with generated PIF configurations.
- Fixed metadata mapping during custom profile generation.
- Fixed fingerprint-derived field generation.
- Various stability improvements and bug fixes.

### Credits
- AutoPIF4 implementation based on the work of [@osm0sis](https://github.com/osm0sis).

---

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
