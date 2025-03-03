# macOS - Hardening - Baseline Security Profile  

## Overview  
This profile combines **CIS recommendations**, **best practices**, and **lessons learned** to enhance the security and privacy of macOS devices. 
It restricts various features and configurations that could introduce security risks, ensuring a more controlled and compliant environment.  

⚠️ **HIGH IMPACT ON PSSO**: When the **Allow Password Auto Fill** is set to `False`, it will break Platform SSO! So if you need PSSO, make sure you set this value to true, or leave it unconfigured.

## Key Features  
This profile disables the following features:  
- **Installation of Configuration Profiles through the User Interface**: Prevents unauthorized or unmonitored configuration changes.  
- **Erase Content and Settings**: Restricts the ability to wipe devices to avoid accidental or malicious data loss.  
- **Cloud Private Relay**: Ensures network traffic remains under organizational control.  
- **iTunes File Sharing**: Blocks file sharing via iTunes to reduce unauthorized data transfer.  
- **File Sharing Modifications**: Prevents changes to file-sharing settings to maintain security policies.  
- **Apple Personalized Advertising**: Disables personalized ads to reduce data sharing with Apple.  
- **Password Proximity Requests**: Blocks password sharing requests based on proximity to other devices.  
- **Password Sharing**: Restricts the ability to share passwords between devices.  
- **Password Auto Fill**: Prevents automatic password filling for enhanced credential security.  ⚠️ WILL BREAK PSSO 

## Configuration Values  
- **Allow Apple Personalized Advertising**: `False`  
- **Allow Password Proximity Requests**: `False`  
- **Allow Password Sharing**: `False`  
- **Allow File Sharing Modification**: `False`  
- **Allow Erase Content and Settings**: `False`  
- **Allow UI Configuration Profile Installation**: `False`  
- **Allow Cloud Private Relay**: `False`  
- **Allow Password Auto Fill**: `False` ⚠️ WILL BREAK PSSO 
- **Allow iTunes File Sharing**: `False`  

## Benefits  
- **Enhanced Security**: Limits features that could expose sensitive data or settings.  
- **Improved Privacy**: Reduces data sharing with third parties and between devices.  
- **Organizational Control**: Ensures tighter control over device configuration and usage.  

## Considerations  
Disabling these features may affect user convenience in some cases. It is important to communicate these changes to users and provide guidance on alternative workflows as needed. This profile is best suited for environments where security and compliance are priorities.  
