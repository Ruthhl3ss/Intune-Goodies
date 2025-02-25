# macOS auditd Restoration Script

## 🚨 Emergency Fix for macOS auditd Issues 🚨

This script is designed to (try and) restore the macOS audit daemon (auditd) when something goes wrong with the audit configuration. It works by restoring the original audit_control settings from the example file.

## 🛠️ What This Script Does

- Backs up your current audit_control file (if it exists)
- Restores audit_control from the example file
- Sets the correct file permissions
- Disables the auditd service
- Reboots the system to apply changes

## ⚠️ WARNING - READ BEFORE DEPLOYMENT ⚠️

**This script will reboot the device when deployed!**

When deploying through Microsoft Intune, pay careful attention to the script scheduling configuration:

- The device will reboot when the policy applies
- There is no recheck functionality to prevent repeated reboots
- If you don't remove the device from the assignment after it's fixed, it will reboot on every script check-in
- Example: If your Intune script is scheduled to run every 15 minutes, the device will reboot every 15 minutes

## 📋 Prerequisites

- macOS device with auditd issues


 **IMPORTANT**: Remove the device from the assignment once the issue is fixed!


## ⚠️ Disclaimer

Use at your own risk. This script modifies system settings.

Use this script ONLY when things go wrong. It is NOT a guarantee but might help you restore original settings.
