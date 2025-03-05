# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Disable Wake for Network Access

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables the ability for macOS devices to wake for network access, reducing risks of unauthorized remote access.

## Key Features  
This profile configures the following features:  

- **Wake on LAN**: Prevents network signals from waking the device from sleep
- **Wake on Modem Ring**: Disables modem-based wake signals
- **Power Management Settings**: Configures power settings across all power sources (AC adapter, battery)

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|--------------------:|-----------------|-------|
| Wake on LAN (Laptop Power) | False | False | |
| Wake On Modem Ring (Laptop Power) | False | False | |
| Wake on LAN (Desktop Power) | False | False | |
| Wake On Modem Ring (Desktop Power) | False | False | |
| Wake on LAN (Laptop Battery Power) | False | False | |
| Wake On Modem Ring (Laptop Battery Power) | False | False | |

**Configure Based on your needs**

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.

## ⚠️  IMPACT
The "Wake for Network Access" feature allows a macOS device to wake from sleep mode to perform tasks, such as providing access to shared resources or responding to management tools. 

However, this capability exposes the device to potential risks, especially on untrusted networks, where malicious actors could send unauthorized wake signals.

Disabling this feature reduces the risk of remote attacks by preventing unauthorized users from waking the system and accessing its resources. 

However, turning off Wake for Network Access may **impact** certain functionalities. For example, management tools like **Apple Remote Desktop** will be unable to wake devices over the network. 

Services like **"Find My Mac"** will not function when the device is asleep. A **remote wipe** will also fail. 

This trade-off should be carefully considered in environments requiring remote management or device tracking.

**Note:** This implements CIS Benchmark 2.9.3 Ensure Wake for Network Access Is Disabled. Only use this profile when the impact is acceptable.