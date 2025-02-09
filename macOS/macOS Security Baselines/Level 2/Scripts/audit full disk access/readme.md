## Audit Apps with Full Disk Access

## NOTE: This only works if you deploy these scripts as a set. You will need 2 scripts for this to work:
1. **audit_apps_with_FullDiskAccess.sh**
2. **report_apps_with_FullDiskAccess.sh**


## audit_apps_with_FullDiskAccess.sh

**Queries the TCC.db** to identify apps granted Full Disk Access.  
**Extracts bundle IDs** of apps with Full Disk Access permissions.  
**Resolves bundle IDs to app names** and writes them to a plist file (`com.company.fulldiskaccess.plist`).

## report_apps_with_FullDiskAccess.sh

**Reads** from `com.company.fulldiskaccess.plist`.  
**Outputs** the list of apps with Full Disk Access to the console for reporting in Intune.

### How to Use

1. **Deploy the scripts using Microsoft Intune**:  
2. **Use the following script settings**: 

## Script settings:
- **Run script as signed-in user:** No (run it as system).
- **Hide script notifications on devices:** Yes.
- **Script frequency:** Depending on how often you want the audit.
- **Max number of times to retry if script fails:** 3 times