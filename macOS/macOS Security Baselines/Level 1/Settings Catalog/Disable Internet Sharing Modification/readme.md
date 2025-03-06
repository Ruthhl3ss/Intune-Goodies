# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Disable Internet Sharing Modification

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables the ability to modify Internet Sharing settings, ensuring that the system cannot share its network connection unintentionally.

## Key Features  
This profile configures the following features:  

- **Internet Sharing Modification**: Prevents users from enabling Internet Sharing
- **Network Routing Controls**: Blocks the device from acting as a network router

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|--------------------:|-----------------|-------|
| Allow Internet Sharing Modification | False | False | |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.

## ⚠️  IMPACT
Internet Sharing allows a Mac to share its internet connection with other devices, effectively functioning as a router. 

While this feature can be useful in certain scenarios, it also increases the system's remote attack surface and may expose the network to unauthorized access.

To enhance security, it is recommended to disable Internet Sharing unless explicitly required. 

This minimizes potential risks associated with unapproved devices accessing the system or network.

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

**Note:** This implements CIS recommendation 2.3.3.8 Ensure Internet Sharing Is Disabled.