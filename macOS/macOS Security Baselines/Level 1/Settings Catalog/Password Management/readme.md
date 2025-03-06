# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Password Management

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration enforces secure password policies, ensuring that user passwords meet organizational security standards.

## Key Features  
This profile configures the following features:  

- **Password Complexity**: Enforces strong password requirements
- **Password Aging**: Controls how frequently passwords must be changed
- **Failed Attempts Handling**: Defines thresholds for failed login attempts
- **Device Lock Settings**: Configures automatic locking timeframes

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Require Complex Passcode | True | True | |
| Change At Next Auth | - | Disabled | ⚠️ Prevents forced password reset at next login |
| Failed Attempts Reset In Minutes | 5 | 15 | |
| Maximum Passcode Age In Days | 365 | 365 | |
| Minimum Passcode Length | 15 | 15 | |
| Maximum Number of Failed Attempts | 5 | 5 | |
| Automatic Device Lock | - | 15 | |
| Minimum Complex Characters | 2 | 2 | |
| PPasscode Reuse Limit | 15 | 15 | |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Account Protection**: Reduces risk of unauthorized access through credential attacks.

## ⚠️  IMPACT
**Password Management: Keep It Secure, Keep It Practical**

⚠️ **HIGH IMPACT:** Make sure **"Change At Next Auth" is disabled**. Check this configuration before deploying it. 
If you do not configure this setting, every user on the device MUST RESET their password at next logon!

**NOTE:** Make sure to test this policy in combination with Platform SSO. 
Do not set these settings in a compliance policy because that will always trigger a password change. 
A passcode setting in a compliance policy **always sets the "Change At Next Auth" to true.**

This configuration implements CIS Benchmark section 5.2 Password Management (Level 1).