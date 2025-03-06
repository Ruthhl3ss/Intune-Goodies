# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - FileVault

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration enables FileVault to ensure that the disk is encrypted, protecting sensitive data from unauthorized access.

## Key Features  
This profile configures the following features:  

- **FileVault Encryption**: Enables full disk encryption for the boot volume
- **Recovery Key Management**: Controls recovery key rotation and visibility
- **FileVault Options**: Prevents users from disabling encryption
- **Recovery Key Escrow**: Configures how recovery keys are managed

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Enable | On | On | |
| Recovery Key Rotation In Months | - | 1 month | |
| Show Recovery Key | - | Disabled | |
| Defer | - | Enabled | |
| Force Enable In Setup Assistant | - | True | |
| Use Recovery Key | - | Enabled | |
| Prevent FileVault From Being Disabled | - | True | |
| Location | - | Call Servicedesk | Instructions for recovery key access |

Configure these settings **based on your needs**

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Data Protection**: Protects confidential information if a device is lost or stolen.

## ⚠️  IMPACT
FileVault is like putting your Mac's data in a super-secure vault—it encrypts everything on your boot volume and requires a password or recovery key to access it. 

Think of it as the ultimate lock to keep your sensitive information safe from prying eyes.

Turning it on is easy and smart!

**Note:** This implements CIS recommendation 2.6.6 Ensure FileVault Is Enabled (Level 1).