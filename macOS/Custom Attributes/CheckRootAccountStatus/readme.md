**CheckRootAccountStatus.sh**

This script checks whether the root account is enabled on a macOS device and reports the result. It is designed to assist administrators in monitoring the root account's status.

**Importance**  
The root account has unrestricted access to the system and poses significant security risks if enabled. Regularly checking its status ensures it remains disabled, minimizing vulnerabilities.

**Key Points**  
- Checks if the root account is enabled or disabled.  
- Reports 'Root account is disabled' if the account is not enabled.  
- Reports 'Root account is enabled' if the account is active.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).
