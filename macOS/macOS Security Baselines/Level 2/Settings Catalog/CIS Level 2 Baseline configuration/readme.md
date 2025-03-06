# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L2 - v1.0 - Baseline Security Configuration

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration implements CIS Benchmark Level 2 settings for macOS, managing various cloud and device integration features.

## Key Features  
This profile configures the following features:  

- **Cloud Services**: Controls iCloud-based feature availability
- **Device Integration**: Manages cross-device functionality like Universal Control
- **Find My Mac**: Configures device location and tracking features
- **App Features**: Manages access to specific applications and services

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Allow Cloud Keychain Sync | False | True | ⚠️ change based on your needs |
| Allow Cloud Document Sync | False | False | |
| Allow Find My Device | False | True |⚠️ change based on your needs |
| Allow Cloud Freeform | False | False | |
| Allow iPhone Mirroring | False | True | ⚠️ change based on your needs |
| Allow Universal Control | False | True | ⚠️ change based on your needs |
| Allow Game Center | False | False | |


## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Balanced Approach**: Provides productivity benefits while maintaining security controls.

## ⚠️  IMPACT
Modern Macs come packed with convenient features like Cloud Keychain Sync, Find My Mac, and Universal Control. While these can boost productivity, they also introduce potential security considerations. This configuration helps you strike a balance between usability and security.

By default, this profile enables several key features, giving you flexibility while maintaining a security-conscious approach. Remember, the goal is to find the sweet spot between user convenience and organizational security policies.

**Note:** This configuration deviates from strict CIS Level 2 recommendations by enabling certain cloud and integration features. Always review and adjust settings to match your organization's specific security requirements and risk tolerance.

**Prerequisites:**
- Microsoft Intune
- macOS device management
- CIS Benchmark familiarity

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review and adjust settings as per your organization's security requirements
3. Assign to appropriate device groups or users