# FIDO Linked Devices Management Scripts

PowerShell scripts to manage FIDO/Passkey linked devices on Windows machines through Microsoft Intune.

## Overview

These scripts help manage and remove FIDO linked devices (passkeys) from Windows machines. They can be deployed as Intune Proactive Remediation scripts.

### Target Registry Path

The scripts target the following registry path:
```
HKEY_USERS\S-1-5-20\Software\Microsoft\Cryptography\FIDO\{DYNAMIC-ID}\LinkedDevices
```
where `{DYNAMIC-ID}` is a unique identifier that varies

## Scripts

### Proactive Remediation

#### Detection Script
- Checks for the presence of linked devices under the FIDO registry path
- Returns 0 if linked devices are found (triggering remediation)
- Returns 1 if no linked devices are found (compliant)

#### Remediation Script
- Removes all device entries under the LinkedDevices key
- Preserves the LinkedDevices key structure
- Includes verbose logging for troubleshooting

## Deployment

### Proactive Remediation
1. In Intune, create a new Proactive Remediation
2. Upload both detection and remediation scripts
3. Configure schedule and scope as needed


## Notes
- Scripts include error handling and verbose logging
- The LinkedDevices key structure is preserved while removing the subkeys
- Suitable for Windows 11 devices managed through Intune
- Can be used to prevent persistent FIDO device linking