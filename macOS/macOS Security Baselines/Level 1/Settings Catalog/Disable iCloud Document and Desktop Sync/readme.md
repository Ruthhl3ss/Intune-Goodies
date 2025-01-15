# CIS Benchmark - Custom Implementation

**Disable iCloud Document and Desktop Sync**

This configuration disables the automatic synchronization of Desktop and Documents folders to iCloud Drive, reducing risks associated with cloud storage.

**Importance**  
This configuration enhances macOS security and aligns with CIS benchmarks. It helps mitigate potential vulnerabilities by implementing recommended settings.

**Key Points**  
- Implements recommended security settings to reduce risk.  
- Aligns with CIS or other hardening standards for macOS.  
- Supports organizational security policies and compliance efforts.

---
**Note:**

Starting with macOS 10.12, Apple introduced the ability to automatically synchronize the contents of the Desktop and Documents folders with iCloud Drive. 
While this feature offers convenience, it may lead to issues such as insufficient storage capacity, especially given the limited free storage provided by Apple.
Additionally, this synchronization could conflict with enterprise data management policies, as it involves storing files in a third-party public cloud.

To ensure compliance and better control over file storage, this feature should be disabled in enterprise environments. 
Organizations can consider using approved alternatives such as Microsoft OneDrive, which offers enterprise-grade features and integration with data management policies.
