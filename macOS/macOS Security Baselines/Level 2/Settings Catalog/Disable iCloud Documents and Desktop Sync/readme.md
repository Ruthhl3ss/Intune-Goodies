# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L2 - v1.0 - Disable iCloud Document and Desktop Sync

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables iCloud Document and Desktop synchronization to enhance data privacy and security on macOS devices.

## Key Features  
This profile configures the following features:  

- **iCloud Document and Desktop Sync**: Prevents automatic cloud synchronization of desktop and document files
- **Cloud Storage Controls**: Restricts automatic file transfers to Apple's cloud servers

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Allow Cloud Desktop And Documents | False | False | ⚠️ pay attention to user adoption |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Data Leak Prevention**: Reduces risk of unintentional data leakage to cloud services.

## ⚠️  IMPACT
iCloud's convenient sync features can be a double-edged sword. While they make file access seamless across devices, they also introduce potential security risks. Automatically syncing desktop and document files to the cloud can unexpectedly expose sensitive information.

This configuration takes a proactive approach to data protection. By disabling iCloud Document and Desktop sync, you regain control over where and how your files are stored and shared.

**Additional considerations:**
- Users will need to manually manage file storage and backups
- Reduced cloud accessibility of desktop and document files
- Increased local data control

**Note:** This implements CIS Benchmark Recommendation 2.1.1.3 Ensure iCloud Drive Document and Desktop Sync Is Disabled (Automated). Always test configuration profiles in a controlled environment before widespread deployment.