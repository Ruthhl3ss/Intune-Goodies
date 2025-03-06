# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Privacy Restrictions

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration enforces privacy settings to limit data sharing and enhance user privacy on macOS devices.

## Key Features  
This profile configures the following features:  

- **Microsoft Edge Telemetry**: Limits diagnostic data collection
- **Microsoft Office Telemetry**: Restricts data sent to Microsoft
- **Apple Advertising**: Disables personalized advertising
- **Diagnostics**: Controls system diagnostic data submission
- **Dictation**: Forces on-device dictation to prevent cloud processing

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Microsoft Edge - Send diagnostic data | - | Required data | |
| Microsoft Office - Diagnostic data level | - | Required data only | |
| Allow Apple Personalized Advertising | False | False | |
| Allow Diagnostic Submission | False | False | |
| Force On Device Only Dictation | - | True | |

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Regulatory Adherence**: Helps meet data privacy regulations requirements.

## ⚠️  IMPACT
Privacy restrictions in macOS play a vital role in controlling how diagnostic and usage data is shared, ensuring compliance with organizational policies and enhancing user privacy. 

These settings allow administrators to limit data collection, restrict app or service access, and enforce privacy-centric configurations across devices.

By implementing these settings, organizations can reduce unnecessary data sharing, align with privacy regulations, and ensure user data remains secure while enabling essential functionality. 

These restrictions create a balance between functionality and privacy, tailored to enterprise needs.

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

**Note:** This implements CIS recommendation 2.6 Privacy & Security (Level 1).