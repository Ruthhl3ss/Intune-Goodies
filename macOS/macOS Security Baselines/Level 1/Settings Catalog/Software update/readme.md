# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Software Update

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration ensures that macOS devices automatically check for and install updates, reducing vulnerabilities from outdated software.

## Key Features  
This profile configures the following features:  

- **Automatic Update Checking**: Ensures regular checks for available updates
- **Critical Update Installation**: Forces installation of security-critical updates
- **App Updates**: Controls automatic installation of application updates
- **Update Download**: Manages how updates are downloaded to devices

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Automatic Check Enabled | True | True | |
| Critical Update Install | True | True | |
| Automatically Install App Updates | - | |
| Config Data Install | - | True | |
| Automatic Download | True | True | |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Vulnerability Reduction**: Minimizes exposure to known security vulnerabilities.

## ⚠️  IMPACT
Configuring the Software Update payload ensures that macOS devices stay current with the latest security patches, critical updates, and application improvements. 

By enabling automatic checks and installations, organizations can maintain a secure and consistent environment while restricting end-user modifications to these settings.

These settings ensure that macOS devices automatically check for updates, download them as needed, and install critical and app updates without user intervention. 

This approach minimizes vulnerabilities while ensuring devices remain compliant with organizational update policies.

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

**Note:** This implements CIS Recommendation 1 Install Updates, Patches and Additional Security Software (Level 1).