# macOS - Hardening - Disable the "root" Account  

## Overview  
The **root** account is a superuser account with full access to the system. It can perform any action and modify any file. While powerful, enabling the root account introduces significant security risks and should remain disabled.  

## Why It’s Important  
- **Reduces Risk**: A disabled root account minimizes the chance of unauthorized access or system compromise.  
- **Prevents Errors**: Actions performed as root can impact the entire system, increasing the risk of accidental changes or damage.  
- **Encourages Secure Practices**: The `sudo` command provides controlled access to administrative privileges, with password protection and logging of actions.  
- **Default Setting**: macOS disables the root account by default, and keeping it disabled is an essential security measure.  

## Key Points  
- The root account should remain disabled to reduce system vulnerabilities.  
- Administrators should use the `sudo` command for tasks requiring elevated privileges.  
- Regular audits should confirm that the root account is not enabled.  
---------------------------------------------------------------------
## Script Settings
Run script as signed-in user : No  
Hide script notifications on devices : Yes  
Script frequency : Not configured (Note: If users are local admin on their device, consider to run this more frequently ("Every 1 day")  
Number of times to retry if script fails : 3  

## Notes
You should also use the Custom Attribute script:CheckRootAccountStatus.sh to periodicallly check the root account status  
If combined, make sure to schedule the scripts to your own needs: Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.
