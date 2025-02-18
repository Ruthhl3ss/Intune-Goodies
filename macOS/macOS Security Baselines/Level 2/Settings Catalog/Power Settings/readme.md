# CIS Benchmark - macOS Power Settings Configuration

**Enhanced Power and Security Settings**

This configuration implements advanced power management settings to improve device security and protect sensitive information.

**Importance**  
Power settings can significantly impact device security, especially when devices are in standby or sleep mode. This configuration provides an additional layer of protection.

**Key Points**  
- Implements CIS Benchmark Recommendation 2.9 (Battery Settings)
- Enhances security during device sleep and standby modes
- Provides granular control over power-related security features

**Caution**  
⚠️ HIGH IMPACT CONFIGURATION
- The "Destroy FV Key On Standby" setting disables Touch ID when coming out of sleep
- Thoroughly test before widespread deployment

---
Power management isn't just about battery life—it's a critical security feature. Modern devices can be vulnerable during sleep or standby modes, and these settings help mitigate potential risks.

By implementing these configurations, you're adding an extra layer of protection that prevents unauthorized access and protects sensitive device information, even when the device appears to be at rest.

**Configured Settings:**
- Destroy FileVault Key on Standby        > Enabled
- Sleep Functionality                     > Allowed

## Prerequisites

- Microsoft Intune
- macOS device management
- Understanding of CIS Benchmark security recommendations

## Deployment

1. Import the JSON configuration to Microsoft Intune
2. Carefully review the settings, especially Touch ID implications
3. Conduct thorough testing in a controlled environment
4. Assign to appropriate device groups or users

## Potential Impacts

- Potential Touch ID functionality changes
- Enhanced security during device sleep
- Increased protection against unauthorized access

## Testing Recommendations

- Test on a small group of devices first
- Verify Touch ID and device unlock behaviors
- Confirm no adverse effects on user workflows

## Disclaimer

Always perform comprehensive testing before widespread deployment. Validate compatibility and user experience carefully.