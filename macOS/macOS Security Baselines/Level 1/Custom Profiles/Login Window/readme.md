## CIS Benchmark - Custom Implementation

**macOS - Hardening - Login Window Configuration**  

**Overview**
This configuration enforces **CIS Recommendation 2.10** for Lock Screen settings to enhance security and user awareness during login. 
It customizes the macOS login window with additional security measures and organizational branding.  

⚠️ HIGH IMPACT ON PSSO: When the **Full Name Login** is confgured, it will break Platform SSO! So if you need PSSO, make sure you DO NOT configure this.

**Why It’s Important**
The login window is the first line of defense for macOS devices. Proper configuration ensures that access is secure and user interactions are guided by clear policies. 
Key features include:  
- Displaying a custom **login message** for organizational identification or instructions.  
- Disabling automatic login to prevent unauthorized access.  
- Requiring full names for login to improve security.  ⚠️ WILL BREAK PSSO 
- Disabling password hints to reduce the risk of guessing attacks.  

**Key Points**  
- **Custom Login Message**: Displays "AllThingsCloud" as the login window text.  
- **Disable Auto Login**: Ensures users must authenticate manually, reducing unauthorized access risks.  
- **Full Name Login**: Requires users to enter their full name for authentication, enhancing login security.  ⚠️ WILL BREAK PSSO 
- **Password Hint Disabled**: Prevents hints from being displayed, reducing exposure to potential attackers.  

⚠️ ## Important Note  
Requiring users to enter their **full username** and password can be challenging, especially in environments where users are not accustomed to this practice. 
There is a risk of users forgetting their usernames, which could lead to increased support requests. To mitigate this:  
- Provide clear communication about the change before implementation.  
- Offer training or guidance to users on how to retrieve or remember their usernames.  
- Ensure IT support teams are prepared to assist users during the transition.
- This configuration will break PSSO!

Balancing security with usability is key to successful implementation of this configuration.  



