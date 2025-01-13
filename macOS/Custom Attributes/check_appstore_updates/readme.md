**check_appstore_updates.sh**

This script checks if macOS is configured to automatically install updates from the App Store and reports the result.

**Importance**  
Ensuring that automatic App Store updates are enabled helps keep software up to date and reduces exposure to known vulnerabilities.

**Key Points**  
- Checks if automatic updates for the App Store are enabled.  
- Reports "PASSED" if automatic updates are enabled.  
- Reports "FAILED" if automatic updates are disabled.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).
