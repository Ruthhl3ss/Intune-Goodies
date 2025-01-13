# CIS Benchmark - Custom Implementation

**macOS - Hardening - Enable Apple Mobile File Integrity (AMFI)**

This configuration ensures that Apple Mobile File Integrity (AMFI) is enabled, which enforces code-signing requirements and helps protect the system from executing unauthorized or malicious software.

**Importance**  
AMFI ensures that only trusted code is executed on macOS devices, reducing the risk of running unverified or harmful software. Enabling this feature aligns with security best practices and minimizes vulnerabilities.

**Key Points**  
- Prevents unauthorized or malicious code execution.  
- Ensures only signed and trusted applications are allowed to run.  
- Aligns with CIS Level 1 benchmarks for securing macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is vital for maintaining system integrity and security.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




