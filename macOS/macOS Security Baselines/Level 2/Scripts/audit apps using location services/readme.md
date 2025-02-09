## Audit Apps that use Location Services

## NOTE: This only works if you deploy these scripts as a set. You will need 3 scripts for this to work:
**1- EnableLocationServiceIcon.sh (optional but recommended)** 

**2- audit_apps_using_Locationservices.sh**

**3- report_apps_using_Locationservices.sh**

The **debug_script_apps_using_Locationservices.sh** is only used to test things locally. No Need to deploy this using Intune

## EnableLocationServiceIcon.sh

This script ensures that the **'Show Location Icon in Control Center when System Services Request Your Location'** setting is enabled on macOS devices. Enabling this setting provides users with visibility into when system services (such as Time Zone, Weather, or Find My Mac) are accessing their location.

### Why Enable the Location Icon?

While system services quietly access location data in the background, enabling this setting enhances transparency by notifying users through the Control Center. This is crucial for maintaining privacy awareness and aligns with security best practices recommended in the **CIS Benchmark**.

### Key Script Functions

- **Check if the Plist Exists**: The script verifies if the `com.apple.locationmenu.plist` file exists in `/Library/Preferences/`.
- **Read Current Setting**: It checks the current status of the `ShowSystemServices` key.
- **Enable Location Icon**: If the setting is not enabled, the script writes the correct value and sets proper permissions.
- **Logging**: Detailed logs are created in `/Library/Logs/Microsoft/IntuneScripts/EnableLocationIcon/EnableLocationIcon.log` for auditing purposes.



## audit_apps_using_Locationservices.sh

**Converts the clients.plist** from binary to XML for easier parsing.
**Extracts bundle IDs** of apps authorized to use Location Services.
**Resolves bundle IDs to app names** and writes them to a plist file (com.company.locationapps.plist).

## report_apps_using_Locationservices.sh
**Reads** from com.company.locationapps.plist.
**Outputs** the list of authorized apps to the console for reporting in Intune.

### How to Use

1. **Deploy the scripts using Microsoft Intune**:
Read the full blog here: https://allthingscloud.blog/whos-watching-auditing-macos-location-services-with-intune/

## Script settings: 
**Run script as signed-in user:** No (run it as system).
**Hide script notifications on devices:** Yes.
**Script frequency:** Depending on how often you want the audit.



