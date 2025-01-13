**Google-Chrome-Update-Check.sh**

This script checks the currently installed version of Google Chrome on a macOS device and attempts to trigger an update check using Google's update agent if the browser is installed.

**What It Does**  
- Retrieves the current version of Google Chrome using the `CFBundleShortVersionString` from the app's `Info.plist` file.  
- Logs the current version and actions taken to `/var/log/forceChromeUpdate.log`.  
- Attempts to trigger a Chrome update check via the `ksadmin` utility from Google's update agent (`GoogleSoftwareUpdate.bundle`).  
- Reports success or failure for the update check.

**Importance**  
Keeping Google Chrome updated ensures the browser has the latest features and security patches. This script automates the process of checking the version and triggering an update if necessary, reducing manual intervention.

**Key Points**  
- Logs the installed version of Google Chrome (or reports "Not Installed" if not found).  
- Triggers an update check using Google's update agent.  
- Reports whether the update check succeeded or failed in the log file.

---

**Note**  
This script is intended for use in managed environments, such as with MDM solutions. It logs all actions for audit purposes.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).
