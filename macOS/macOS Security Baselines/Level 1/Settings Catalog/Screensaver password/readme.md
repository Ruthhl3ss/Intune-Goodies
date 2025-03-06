# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Screensaver Password

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration ensures that a password is required to unlock the system after the screensaver activates, enhancing physical security.

## Key Features  
This profile configures the following features:  

- **Screensaver Password**: Enforces password protection when returning from screensaver
- **Idle Time Settings**: Controls when screensaver activates after inactivity
- **Password Delay**: Determines how quickly password protection engages
- **Screensaver Module**: Defines which screensaver module is used

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Ask For Password | True | True | |
| Ask For Password Delay | - | 1 | (1 = immediate) |
| Login Window Idle Time | - | 1200 | (20 minutes) |
| Module Name | - | /System/Library/Screen Savers/Random.saver | Screensaver module to use |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Physical Security**: Protects against unauthorized access to unattended devices.

## ⚠️  IMPACT
Screensaver settings on macOS can be configured to secure devices during periods of inactivity, reducing the risk of unauthorized access. 

By enforcing a password prompt after the screensaver activates and setting idle time limits, organizations can ensure devices are protected when left unattended.

These configurations ensure that a password is required shortly after the screensaver activates, while also enforcing a 20-minute idle time limit. 

Using the "Random" screensaver module adds variety, and these settings collectively enhance device security by mitigating risks from unattended systems.

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

**Note:** This implements CIS Recommendation 2.10 Lock Screen (Level 1).