**check_diagnostic_data.sh**

This script checks if macOS is configured to send diagnostic data to Apple and reports the result. Sharing diagnostic data may expose sensitive information, and disabling it helps maintain privacy.

**Importance**  
Sending diagnostic data may expose sensitive organizational information. Verifying this configuration helps ensure compliance with privacy policies.

**Key Points**  
- Checks if diagnostic data sharing is enabled.  
- Reports 'Diagnostic data sharing is disabled' if the feature is turned off.  
- Reports 'Diagnostic data sharing is enabled' if the feature is active.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).
