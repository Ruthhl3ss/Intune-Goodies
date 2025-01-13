# CIS Benchmark - Custom Implementation

**macOS - Hardening - Disable Remote Login**

This configuration disables the Remote Login feature (SSH) on macOS, reducing exposure to unauthorized remote access attempts.

**Importance**  
Disabling Remote Login ensures that the system cannot be accessed remotely via SSH, minimizing the risk of brute-force attacks or unauthorized access.

**Key Points**  
- Prevents unauthorized remote access via SSH.  
- Reduces exposure to network-based attacks.  
- Aligns with CIS Level 1 benchmarks for securing macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is critical for systems where remote access is not required.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




