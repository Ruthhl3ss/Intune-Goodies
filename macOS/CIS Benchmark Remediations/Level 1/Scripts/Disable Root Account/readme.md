# CIS Benchmark - Custom Implementation

**macOS - Hardening - Disable Root Account**

This configuration disables the root account on macOS, ensuring that the system is protected from unauthorized superuser access.

**Importance**  
The root account has unrestricted access to the system and can perform any operation, making it a high-value target for attackers. Disabling this account minimizes the risk of misuse or exploitation.

**Key Points**  
- Prevents unauthorized superuser access.  
- Reduces the attack surface by limiting privilege escalation.  
- Aligns with CIS Level 1 benchmarks for securing macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is essential for maintaining a secure macOS environment.




