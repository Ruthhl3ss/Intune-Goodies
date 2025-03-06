# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L2 - v1.0 - Disable Content Caching

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables content caching to enhance privacy and security on macOS devices.

## Key Features  
This profile configures the following features:  

- **Shared Content Caching**: Prevents the device from caching and sharing downloaded content
- **Network Resource Sharing**: Restricts exposure of device resources on the network

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Allow Shared Caching | False | False | |

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Reduced Network Exposure**: Minimizes potential attack surface on local networks.

## ⚠️  IMPACT
Content caching might seem convenient, but it can inadvertently expose your device's network resources and downloaded content to other devices. This configuration takes a proactive approach to minimize potential security risks associated with shared caching mechanisms.

By default, this profile completely disables shared content caching, giving you tighter control over your device's resource sharing capabilities. It's a small change that can make a significant difference in your overall security posture.

**Potential Impact:**
- May slightly increase download times for repeated content
- Ensures maximum privacy and reduced network exposure

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the settings to ensure they meet your specific security requirements
3. Assign to appropriate device groups or users