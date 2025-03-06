# CIS Benchmark Custom Implementation
## Profile name: macOS - Hardening - CIS_L2 - v1.0 - Power settings

## Overview
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

This configuration implements advanced power management settings to improve device security and protect sensitive information.

## Key Features  
This profile configures the following features:  

- **FileVault Key Management**: Controls how encryption keys are handled during standby
- **Sleep Settings**: Manages device sleep behavior for security purposes

## Configuration Values  
| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|-------------------|-----------------|-------|
| Sleep Disabled | - | False | ⚠️ Allows normal sleep functionality |
| Destroy FV Key On Standby | True | True | |

Based on your needs

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  
- **Compliance Alignment**: Supports organizational security policies and compliance efforts.
- **Sleep Mode Protection**: Adds security during device sleep and standby states.

## ⚠️  IMPACT
Power management isn't just about battery life—it's a critical security feature. Modern devices can be vulnerable during sleep or standby modes, and these settings help mitigate potential risks.

By implementing these configurations, you're adding an extra layer of protection that prevents unauthorized access and protects sensitive device information, even when the device appears to be at rest.

**⚠️ HIGH IMPACT CONFIGURATION**
- The "Destroy FV Key On Standby" setting disables Touch ID when coming out of sleep
- Thoroughly test before widespread deployment

**Potential Impacts:**
- Potential Touch ID functionality changes
- Enhanced security during device sleep
- Increased protection against unauthorized access

**Testing Recommendations:**
- Test on a small group of devices first
- Verify Touch ID and device unlock behaviors
- Confirm no adverse effects on user workflows

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Carefully review the settings, especially Touch ID implications
3. Conduct thorough testing in a controlled environment
4. Assign to appropriate device groups or users

**Note:** This implements CIS Benchmark Recommendation 2.9 (Battery Settings). Always perform comprehensive testing before widespread deployment.