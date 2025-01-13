# CIS Benchmark - Custom Implementation

**macOS - Hardening - Admin Password for System-Wide Settings**

This configuration ensures that changes to system-wide settings require an administrator password, providing an additional layer of security.

**Importance**  
Requiring an administrator password prevents unauthorized users from making critical changes to system settings, safeguarding the system from misconfigurations or malicious alterations.

**Key Points**  
- Restricts access to system-wide settings to administrators only.  
- Prevents accidental or unauthorized changes.  
- Aligns with CIS Level 1 benchmarks for securing macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is essential for maintaining control over system settings.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




