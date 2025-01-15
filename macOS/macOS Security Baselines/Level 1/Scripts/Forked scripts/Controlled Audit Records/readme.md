# CIS Benchmark - Custom Implementation

**macOS - Hardening - Controlled Audit Records**

This configuration ensures proper control and management of audit records on macOS devices, helping organizations maintain accountability and traceability for system activities.

**Importance**  
Audit records provide valuable insights into system activities and are crucial for compliance and forensic investigations. Ensuring these records are well-controlled reduces the risk of data manipulation or unauthorized access.

**Key Points**  
- Maintains integrity and accessibility of audit records.  
- Enhances compliance with organizational policies and regulatory requirements.  
- Aligns with CIS Level 1 benchmarks for audit management.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is essential for organizations prioritizing audit compliance and accountability.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




