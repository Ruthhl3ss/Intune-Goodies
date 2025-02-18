# CIS Benchmark - macOS Level 2 Baseline Security Configuration

**Cloud Services and Feature Management**

This configuration implements CIS Benchmark Level 2 settings for macOS, managing various cloud and device integration features.

**Importance**  
This configuration provides a balanced approach to macOS security, enabling key cloud services while maintaining control over device integrations. It allows specific features while providing a framework for organizational security management.
It is a custom implementation and needs to be reviewed to meet your requirements.

**Key Points**  
- Provides granular control over cloud and device features
- Supports enterprise mobility and device management strategies
- Configurable to meet specific organizational security requirements

---
Modern Macs come packed with convenient features like Cloud Keychain Sync, Find My Mac, and Universal Control. While these can boost productivity, they also introduce potential security considerations. This configuration helps you strike a balance between usability and security.

By default, this profile enables several key features, giving you flexibility while maintaining a security-conscious approach. Remember, the goal is to find the sweet spot between user convenience and organizational security policies.

**Configured Features:**

- Cloud Keychain Sync         > Allowed
- iCloud Drive                > Allowed
- Freeform                    > Allowed
- Find My Mac                 > Allowed
- Game Center                 > Allowed
- iPhone Mirroring            > Allowed
- Universal Control           > Allowed

## Prerequisites

- Microsoft Intune
- macOS device management
- CIS Benchmark familiarity

## Deployment

1. Import the JSON configuration to Microsoft Intune
2. Review and adjust settings as per your organization's security requirements
3. Assign to appropriate device groups or users


## Disclaimer

Always test configuration profiles in a controlled environment before widespread deployment. Validate compatibility and impact on user experience.
