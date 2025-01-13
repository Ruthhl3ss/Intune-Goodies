# CIS Benchmark - Custom Implementation

**macOS - Hardening - Disable NFS Server**

This configuration disables the Network File System (NFS) server on macOS. NFS can introduce vulnerabilities if improperly configured or exposed to untrusted networks.

**Importance**  
Disabling the NFS server reduces the risk of unauthorized access to file shares and minimizes the system’s exposure to network-based attacks.

**Key Points**  
- Prevents unauthorized access to file shares via NFS.  
- Reduces attack surface by disabling unused network services.  
- Aligns with CIS Level 1 benchmarks for securing macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is recommended for systems where NFS functionality is not explicitly required.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




