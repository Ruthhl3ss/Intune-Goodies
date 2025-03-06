# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L2 - v1.0 - Notifications and Focus

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration implements strict notification controls for Microsoft applications, enhancing device privacy and security.

## Key Features  
This profile configures the following features:  

- **Lock Screen Notifications**: Disables notifications on the lock screen for sensitive applications
- **Application-Specific Controls**: Manages notification settings for Microsoft and Apple apps
- **Information Exposure Prevention**: Reduces risk of sensitive data being visible on locked devices

## Configuration Values  
| Configuration Name | Bundle Identifier | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-------------------|-----------------|-------|
| Show In Lock Screen (Microsoft Outlook) | com.microsoft.Outlook | False | False | |
| Show In Lock Screen (Microsoft OneDrive) | com.microsoft.OneDrive | False | False | |
| Show In Lock Screen (Microsoft Edge) | om.microsoft.edgemac | False | False | |
| Show In Lock Screen (Apple Messages) | com.apple.MobileSMS | False | False | |
| Show In Lock Screen (Microsoft Teams) | com.microsoft.teams | False | False | |
| Show In Lock Screen (Microsoft Teams 2) | com.microsoft.teams2 | False | False | |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Data Exposure Reduction**: Prevents sensitive information from appearing on lock screens.

## ⚠️  IMPACT
Notifications might seem harmless, but they can be a significant privacy risk. Imagine sensitive email previews or message snippets visible to anyone near your device. This configuration takes a proactive approach to lock down potentially revealing notifications.

By carefully managing notification settings, we create an additional layer of security that protects your digital footprint—one notification at a time.

**Potential Impact:**
- Reduced visibility of sensitive information on lock screens
- Users must unlock devices to view full notification details
- Enhanced privacy protection

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

**Note:** This implements CIS Benchmark Recommendation 2.15.1. Adjust according to your requirements before deploying.