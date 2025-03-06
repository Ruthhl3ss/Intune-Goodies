# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Gatekeeper

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration ensures that Gatekeeper is enabled, allowing only trusted and verified applications to run on macOS.

## Key Features  
This profile configures the following features:  

- **Gatekeeper**: Enforces app verification and blocks unsigned applications
- **XProtect**: Enables malware detection and reporting
- **System Policy Controls**: Prevents users from overriding security settings

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Enable XProtect Malware Upload | - | Enabled | |
| Allow Identified Developers | True | True | |
| Enable Assessment | True | True | |
| Disable Override | - | True | |


## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Malware Protection**: Significantly reduces the risk of malicious software installation.

## ⚠️  IMPACT
Gatekeeper is macOS's built-in security feature that helps protect your system from running untrusted or malicious software. 

It ensures that only apps downloaded from the Mac App Store or identified developers (those who are verified by Apple) can run on your system, reducing the risk of accidentally installing malware.

By requiring apps to be signed and notarized, Gatekeeper acts as a filter, blocking potentially harmful applications while still giving you control to allow trusted exceptions when necessary. 

It's a critical layer of security that works seamlessly in the background, keeping your Mac safe without compromising usability.

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

**Note:** This implements CIS recommendation 2.6.5 Ensure Gatekeeper Is Enabled (Level 1).