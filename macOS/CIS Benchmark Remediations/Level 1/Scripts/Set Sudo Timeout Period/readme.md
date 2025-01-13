# CIS Benchmark - Custom Implementation

**macOS - Hardening - Set Sudo Timeout Period to Zero**

This configuration sets the sudo timeout period to zero, requiring users to re-enter their password every time they invoke a sudo command.

**Importance**  
Requiring immediate re-authentication for sudo commands reduces the risk of unauthorized use in cases where the terminal is left unattended.

**Key Points**  
- Enforces password entry for every sudo command.  
- Minimizes the risk of privilege escalation through unattended terminals.  
- Aligns with CIS Level 1 benchmarks for macOS security.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is ideal for environments requiring strict access control.
