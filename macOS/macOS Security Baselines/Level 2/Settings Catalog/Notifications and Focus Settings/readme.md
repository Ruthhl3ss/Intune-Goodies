# CIS Benchmark - macOS Notifications and Focus Configuration

**Enhanced Notification Privacy**

This configuration implements strict notification controls for Microsoft applications, enhancing device privacy and security.

**Importance**  
Notifications can expose sensitive information, especially when displayed on lock screens. This configuration helps prevent unintended information disclosure.

**Key Points**  
- Implements CIS Benchmark Recommendation 2.15.1
- Disables lock screen notifications for key Microsoft applications
- Reduces risk of information leakage
- Supports organizational privacy and security standards

---
Notifications might seem harmless, but they can be a significant privacy risk. Imagine sensitive email previews or message snippets visible to anyone near your device. This configuration takes a proactive approach to lock down potentially revealing notifications.

By carefully managing notification settings, we create an additional layer of security that protects your digital footprint—one notification at a time.

**Configured Applications:**
- Microsoft Outlook
- Microsoft OneDrive
- Microsoft Edge
- Messages
- Microsoft Teams (both versions)

**Notification Settings:**
- Lock Screen Display        > Disabled

## Prerequisites

- Microsoft Intune
- macOS device management
- Understanding of CIS Benchmark privacy recommendations

## Deployment

1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users

## Potential Impact

- Reduced visibility of sensitive information on lock screens
- Users must unlock devices to view full notification details
- Enhanced privacy protection

## Disclaimer

Always test configuration profiles in a controlled environment. Validate compatibility and impact on user experience before widespread deployment.