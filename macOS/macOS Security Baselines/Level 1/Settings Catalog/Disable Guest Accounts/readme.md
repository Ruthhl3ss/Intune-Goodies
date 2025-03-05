# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L1 - v1.0 - Disable Guest Accounts

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration disables guest accounts on macOS, ensuring that unauthorized users cannot access the system.

## Key Features  
This profile configures the following features:  

- **Guest Account**: Disables the ability for anyone to log in without credentials
- **Account Restrictions**: Prevents temporary system access without authentication

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|--------------------:|-----------------|-------|
| Enable Guest Account | False | False | Prevents login without credentials |
| Disable Guest Account | True | True | Explicitly disables guest account functionality |

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.

## ⚠️  IMPACT
The guest account in macOS provides access to the system without requiring a username or password. 

While it limits guest users from making system changes or logging in remotely, it still allows temporary access, with all data removed after logout.

Disabling the guest account is recommended to reduce the risk of unauthorized users performing basic reconnaissance or attempting privilege escalation attacks. 

This measure enhances overall system security.