# Disable Root User account 
This Custom Script is required when implementing following CIS or NIST Recommendations for macOS:

CIS: 5.6 Ensure the "root" Account Is Disabled

## Script Settings
Run script as signed-in user : No  
Hide script notifications on devices : Yes  
Script frequency : Not configured (Note: If users are local admin on their device, you should consider to run this more frequently such as "Every 1 day")  
Number of times to retry if script fails : 3  

## Notes
You should also use the Custom Attribute script:CheckRootAccountStatus.sh to periodicallly check the root account status  
If combined, make sure to schedule the scripts to your own needs: Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.
