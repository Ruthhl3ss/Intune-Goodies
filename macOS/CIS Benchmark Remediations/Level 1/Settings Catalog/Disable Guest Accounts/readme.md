# CIS Benchmark - Custom Implementation

**Disable Guest Accounts**

This configuration disables guest accounts on macOS, ensuring that unauthorized users cannot access the system.

**Importance**  
This configuration enhances macOS security and aligns with CIS benchmarks. It helps mitigate potential vulnerabilities by implementing recommended settings.

**Key Points**  
- Implements recommended security settings to reduce risk.  
- Aligns with CIS or other hardening standards for macOS.  
- Supports organizational security policies and compliance efforts.

---
This configuration profile disables the guest account

**Note:**

The guest account in macOS provides access to the system without requiring a username or password. 
While it limits guest users from making system changes or logging in remotely, it still allows temporary access, with all data removed after logout.

Disabling the guest account is recommended to reduce the risk of unauthorized users performing basic reconnaissance or attempting privilege escalation attacks. 
This measure enhances overall system security.
