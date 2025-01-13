**check_nfs_disabled.sh**

This script checks if the Network File System (NFS) is disabled on macOS and reports the result. It ensures that file-sharing services are not unintentionally enabled.

**Importance**  
NFS can expose sensitive data to unauthorized users if misconfigured. Regularly verifying its status helps maintain a secure system.

**Key Points**  
- Checks if NFS is disabled.  
- Reports 'NFS is disabled' if the service is not running.  
- Reports 'NFS is enabled' if the service is active.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).
