# CIS Benchmark - Custom Implementation

**macOS - Hardening - Disable HTTP Server**

This configuration disables the built-in HTTP server (Apache) on macOS, which is often unnecessary for most environments and could expose the system to web-based attacks.

**Importance**  
Disabling the HTTP server reduces the attack surface by eliminating unused web services that could be exploited if left running unintentionally.

**Key Points**  
- Prevents unauthorized use of the HTTP server.  
- Reduces the risk of web-based vulnerabilities.  
- Aligns with CIS Level 1 benchmarks for macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is recommended for systems that do not require web server functionality.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




