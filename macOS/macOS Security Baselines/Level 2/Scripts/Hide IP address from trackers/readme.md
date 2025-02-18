# macOS Safari IP Address Privacy Setting Script

This script implements the CIS Benchmark recommendation 6.3.5 for macOS, which configures Safari's IP address hiding settings for trackers and websites. The script can be deployed via Microsoft Intune to manage this setting across your macOS fleet.

## CIS Benchmark Details

**Recommendation:** 6.3.5 Audit Hide IP Address in Safari Setting  
**Level:** 1  
**Description:** Configure Safari to hide IP addresses from trackers to enhance privacy and prevent location tracking.

### Security Impact
- Prevents trackers from correlating visits through IP addresses.
- Enhances user privacy.
- May affect services using IP geolocation.
- Could impact websites using IP-based access controls.

## Configuration Values

## Current confirmed values (macOS Sequoia 15.3.1):

66976992 - Disabled
66976996 - Trackers Only
66977004 - Trackers and Websites

## Historical/Legacy values (DO NOT USE - may cause Safari to crash):
33422560 - Disabled (OLD)
33422564 - Trackers Only (OLD)
33422572 - Trackers and Websites å(OLD)
**Note:** The CIS Benchmark documentation references these values but I think they are older values that are no longer valid. Make sure you test this on a testdevice.
**Using these older values may cause Safari to crash**

## Test
- defaults read /Users/$USER/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WBSPrivacyProxyAvailabilityTraffic
- make a note for the value you get. For example 66977004
- Open Safari.
- Go to Safari > Settings > Privacy.
- Check "Hide IP address from trackers" setting.
- Change settings here and try again with **defaults read** to see what values you get


## Prerequisites
- macOS device managed by Intune.
- Terminal must have Full Disk Access.
- Files Modified /Users/<username>/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari


#### Intune Script Settings
* **Run script as signed-in user:** No
* **Hide script notifications on devices:** Yes
* **Script frequency:** Not configured (or any other setting you want)
* **Max number of times to retry if script fails:** 3 times


## Sample Log Output

2025-02-18 10:15:23 | INFO | Starting SafariIPHiding
2025-02-18 10:15:23 | INFO | Target Setting: Trackers Only
2025-02-18 10:15:23 | INFO | Processing user: username
2025-02-18 10:15:23 | INFO | Setting already configured correctly for user username (Trackers Only)
2025-02-18 10:15:23 | INFO | Processing user: username2
2025-02-18 10:15:23 | INFO | Changing setting for username2 from Disabled to Trackers Only
2025-02-18 10:15:23 | SUCCESS | Successfully updated Safari IP hiding setting for user username2

## Troubleshooting
If Safari crashes after setting changes:

# Kill Safari processes
killall -9 Safari

# Reset to known good value (e.g., Trackers Only)
/usr/bin/sudo -u <username> /usr/bin/defaults write /Users/<username>/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari WBSPrivacyProxyAvailabilityTraffic -int 66977004

# Restart Safari
open -a Safari
Compliance Verification
To verify the configuration:

Open Safari.
Go to Safari > Settings > Privacy.
Check "Hide IP address from trackers" setting.

## Known Issues
- Configuration requires Full Disk Access for Terminal/script execution.
- May affect services using IP-based geolocation.
- Could impact websites using IP-based access controls.
- Old CIS benchmark values will cause Safari to crash.
- Settings might reset on Safari updates.
