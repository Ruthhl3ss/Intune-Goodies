# CIS Benchmark - Custom Implementation

**macOS - Hardening - Show All Filename Extensions**

This configuration ensures that filename extensions are always visible, making it easier to identify file types and reducing the risk of accidental execution of malicious files disguised as safe ones.

**Importance**  
Displaying all filename extensions helps users make informed decisions when opening files, reducing the likelihood of executing harmful files that use deceptive extensions.

**Key Points**  
- Makes all filename extensions visible to users.  
- Enhances user awareness of file types, reducing the risk of opening malicious files.  
- Aligns with CIS Level 1 benchmarks for macOS security.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is recommended for all systems to improve user awareness and security.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




