# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L2 - v1.0 - Disable Content Caching

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables macOS content caching to prevent unauthorized use of the system as a caching server.

## Key Features  
This profile configures the following features:  

- **Content Caching**: Disables the system's ability to save and serve local copies of content to other Apple devices
- **Shared Caching**: Prevents the sharing of downloaded content across multiple devices

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|--------------------:|-----------------|-------|
| Allow Shared Caching | False | False | Prevents the device from acting as a content cache server |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.

## ⚠️  IMPACT
Content Caching, introduced in macOS High Sierra (10.13), is a feature designed to reduce internet bandwidth usage by caching Apple updates and content locally. 

While it can be valuable in environments with constrained internet bandwidth, its benefits are limited to specific scenarios, such as controlled enterprise networks.

For general use, particularly on mobile devices or untrusted networks, enabling Content Caching may pose security risks and add management complexity. 

Disabling this feature is recommended unless there is a specific operational requirement.

**Note:** This is a CIS Level 2 recommendation (2.3.3.9 Ensure Content Caching Is Disabled).