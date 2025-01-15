# CIS Benchmark - Custom Implementation

**macOS - Hardening - Delete Guest Home Folder**

This configuration removes the guest user's home folder, which prevents any data persistence for guest accounts and further restricts their system usage.

**Importance**  
Guest accounts should not retain any data or settings after a session ends. Deleting the guest home folder ensures no residual data remains, maintaining the system's integrity and security.

**Key Points**  
- Ensures guest accounts do not retain data or settings.  
- Prevents unauthorized data persistence on the system.  
- Supports CIS recommendations for securing guest accounts.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is particularly relevant for shared systems.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




