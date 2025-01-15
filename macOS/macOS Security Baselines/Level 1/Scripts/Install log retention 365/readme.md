# CIS Benchmark - Custom Implementation

**macOS - Hardening - Install Log Retention for 365 Days**

This configuration sets the retention period for installation logs to 365 days, ensuring that historical data is preserved for audits and troubleshooting.

**Importance**  
Retaining installation logs for an extended period helps administrators track system changes, detect unauthorized installations, and troubleshoot issues effectively.

**Key Points**  
- Extends log retention to 365 days for better traceability.  
- Supports compliance with audit and forensic investigation requirements.  
- Aligns with CIS Level 1 benchmarks for log management.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is recommended for environments that require detailed historical logs.
