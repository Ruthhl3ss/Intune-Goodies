# CIS Benchmark - Custom Implementation

**macOS - Hardening - Disable File Sharing**

This configuration disables the file sharing service on macOS, preventing unauthorized access to shared folders and reducing the risk of data exposure.

**Importance**  
Disabling file sharing ensures that shared folders are not accessible over the network, minimizing the risk of unauthorized access or data leakage. This is particularly important in environments where file sharing is not needed.

**Key Points**  
- Prevents unauthorized access to shared files over the network.  
- Reduces the system's exposure to potential data breaches.  
- Aligns with CIS Level 1 benchmarks for macOS security.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is essential for systems that do not require file sharing capabilities.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




