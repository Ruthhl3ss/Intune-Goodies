# CIS Benchmark - Custom Implementation

**macOS - Hardening - Enable Sudo Logging**

This configuration enables logging of all `sudo` commands executed on the system, enhancing accountability and traceability.

**Importance**  
Enabling sudo logging ensures that all administrative actions are recorded, providing an audit trail for system activities. This helps detect unauthorized or suspicious activity.

**Key Points**  
- Tracks all `sudo` commands executed on the system.  
- Enhances auditability and accountability.  
- Aligns with CIS Level 1 benchmarks for macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is critical for environments requiring strict audit controls.
