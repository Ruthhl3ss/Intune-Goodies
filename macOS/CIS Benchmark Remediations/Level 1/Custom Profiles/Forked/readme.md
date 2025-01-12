## Forked files

**Overview**  
While most of the scripts are my own, some of them are saved here from other repositories for my own (and perhaps your) convenience. 
However, collected/forked scripts/file will always have the original authors name in the script and I'll always try to link to the original files.
The original files can be found at: https://github.com/microsoft/shell-intune-samples/tree/master/macOS . 

**macOS - Hardening - Terminal Full Disk Access**

**Overview**
This configuration allows **Full Disk Access** for the Terminal app, **which is necessary for implementing specific security recommendations** outlined in CIS and NIST benchmarks for macOS. 
It ensures that administrative tasks and security configurations requiring Terminal access to system files can be completed effectively.  

Enabling Full Disk Access for Terminal is essential for enforcing key security measures, such as:  
- **CIS Recommendations**:
  - Ensuring **Remote Login** is disabled.
  - Disabling **Remote Apple Events**.  
- **NIST Guidelines**:
  - Disabling the **SSH Server** for remote access sessions.
  - Disabling **Remote Apple Events**.  

By providing Terminal with Full Disk Access, administrators can execute required configurations while maintaining compliance with security frameworks.  

**Key Points**
- **Required for Compliance**: Necessary to meet CIS and NIST hardening standards.  
- **Scoped Access**: Ensures only the Terminal app has the required access, limiting potential misuse.  
- **No Impact to Functionality**: This configuration does not affect standard system operations or user workflows.  

**NOTE**
Make sure you also implement CIS recommnedation **2.6.2.1 Audit Full Disk Access for Applications**
