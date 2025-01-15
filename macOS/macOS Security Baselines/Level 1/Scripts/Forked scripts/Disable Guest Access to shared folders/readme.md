# CIS Benchmark - Custom Implementation

**macOS - Hardening - Disable Guest Access to Shared Folders**

This configuration disables guest access to shared folders, ensuring that unauthorized users cannot access shared resources on the system.

**Importance**  
Allowing guest access to shared folders introduces significant security risks, as it provides potential attackers with an entry point to access system data. Disabling this feature ensures that shared resources remain accessible only to authorized users.

**Key Points**  
- Prevents unauthorized users from accessing shared folders.  
- Reduces the risk of data leakage or unauthorized modifications.  
- Aligns with CIS Level 1 benchmarks for macOS security.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is essential for systems in shared or networked environments.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




