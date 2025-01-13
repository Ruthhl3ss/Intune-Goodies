# CIS Benchmark - Custom Implementation

**macOS - Hardening - Permissions for Systemwide Applications**

This configuration ensures that permissions for systemwide applications are restricted to authorized users, preventing unauthorized modifications.

**Importance**  
Restricting application permissions reduces the risk of unauthorized changes or malicious activity, maintaining the integrity of systemwide applications.

**Key Points**  
- Protects systemwide applications from unauthorized modifications.  
- Reduces the risk of privilege escalation attacks.  
- Aligns with CIS Level 1 benchmarks for macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is essential for securing critical system components.
