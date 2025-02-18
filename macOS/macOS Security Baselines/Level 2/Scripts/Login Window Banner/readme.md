# macOS Login Window Banner Script

This script implements CIS Benchmark recommendation 5.8 for macOS, which requires a login window warning banner to be displayed to users before they log in.

## CIS Benchmark Details

**Recommendation:** 5.8 Ensure Login Window Banner Exists  
**Level:** 2  
**Description:** Display a warning message at the login window to inform users that the system is for authorized use only.

### NOTE
- I'm using the TXT file format, You can also use an RTF file format. Check the CIS benchmark for more info

### Security Impact
- Provides clear warning about unauthorized access
- Documents that activity is monitored
- Supports legal requirements for notification
- May be required for compliance frameworks

## Script Overview

The script `create_policy_banner.sh` creates and configures a login window banner on macOS systems by:
1. Creating the banner text file
2. Setting appropriate permissions 
3. Verifying the configuration

### Prerequisites
- macOS device managed by Intune

### Files Created
- `/Library/Security/PolicyBanner.txt` - Contains the warning message
- `/Library/Logs/Microsoft/IntuneScripts/CreatePolicyBanner/CreatePolicyBanner.log` - Script logs

### Default Warning Message
WARNING: This system is for authorized use only.
By using this system, you agree to be bound by all policies and regulations.
Unauthorized access or use of this system is strictly prohibited and may result in disciplinary action, civil, and/or criminal penalties.
All activities on this system are logged and monitored.
Copy
## Deployment

### Intune Deployment
1. Upload the script as a shell script in Intune

#### Intune Script Settings
* **Run script as signed-in user:** No
* **Hide script notifications on devices:** Yes
* **Script frequency:** Not configured (or any other setting you want)
* **Max number of times to retry if script fails:** 3 times