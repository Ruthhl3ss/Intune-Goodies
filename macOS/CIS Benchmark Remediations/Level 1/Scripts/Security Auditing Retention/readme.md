# CIS Benchmark - Custom Implementation

**macOS - Hardening - Ensure Security Auditing Retention Is Enabled**

This configuration ensures that security audit logs are retained for an extended period, supporting compliance and investigation needs.

**Importance**  
Enabling security audit retention helps organizations track system activity, detect anomalies, and support forensic investigations.

**Key Points**  
- Retains security audit logs for compliance and accountability.  
- Provides valuable insights for detecting and responding to incidents.  
- Aligns with CIS Level 1 benchmarks for macOS security.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is critical for maintaining a comprehensive audit trail.
