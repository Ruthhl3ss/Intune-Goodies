# CIS Benchmark - Custom Implementation

**macOS - Hardening - Secure User’s Home Folders**

This configuration secures user home folders by ensuring that only authorized users can access the content within them.

**Importance**  
Restricting access to user home folders prevents unauthorized users from viewing or modifying sensitive data, maintaining user privacy and data integrity.

**Key Points**  
- Protects sensitive user data from unauthorized access.  
- Enforces privacy and security best practices.  
- Aligns with CIS Level 1 benchmarks for macOS.  

**Script Settings**  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

This configuration is highly recommended for shared or multi-user systems.

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS 




