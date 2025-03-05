# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Disable AirDrop and Handoff

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables AirDrop and Handoff features, reducing the risk of unintended data sharing or exposure.

## Key Features  
This profile configures the following features:  

- **AirDrop**: Disables file sharing between Apple devices to prevent data leakage
- **Handoff/Activity Continuation**: Prevents automatic transfer of activities between devices
- **AirPlay Incoming Requests**: Blocks unauthorized screen sharing requests

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|--------------------:|-----------------|-------|
| Allow Air Play Incoming Requests | False | False | Prevents unauthorized streaming to the device |
| Allow Activity Continuation | False | False | Disables Handoff functionality between devices |
| Allow AirDrop | False | False | Blocks file sharing via AirDrop to prevent data leakage |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.

## ⚠️  IMPACT
AirDrop is super handy for sharing files between Apple devices, but leaving it on all the time can expose your device to privacy risks and unwanted file requests. The best practice? Keep it off by default and only switch it on when you actually need to send or receive files.

AirPlay Receiver, which lets you share your screen with other Apple devices, is another great feature—but it's better to use it only when needed. Leaving it on all the time could lead to misuse or even denial-of-service issues. By setting up configuration profiles, you can easily keep these features off by default and stay secure.