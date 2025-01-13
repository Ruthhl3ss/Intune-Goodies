# CIS Benchmark - Custom Implementation

**Disable AirDrop and Handoff**

This configuration disables AirDrop and Handoff features, reducing the risk of unintended data sharing or exposure.

**Importance**  
This configuration enhances macOS security and aligns with CIS benchmarks. It helps mitigate potential vulnerabilities by implementing recommended settings.

**Key Points**  
- Implements recommended security settings to reduce risk.  
- Aligns with CIS or other hardening standards for macOS.  
- Supports organizational security policies and compliance efforts.

---

## CIS Benchmark - Custom Implementation

This configuration profile Ensures AirDrop Is Disabled When Not Actively Transferring Files. 

AirDrop is super handy for sharing files between Apple devices, but leaving it on all the time can expose your device to privacy risks and unwanted file requests. The best practice? Keep it off by default and only switch it on when you actually need to send or receive files.

AirPlay Receiver, which lets you share your screen with other Apple devices, is another great feature—but it’s better to use it only when needed. Leaving it on all the time could lead to misuse or even denial-of-service issues. By setting up configuration profiles, you can easily keep these features off by default and stay secure.

**Configured items:**

- Allow Air Play Incoming Requests   > Disabled
- Allow Activity Continuation        > False
- Allow AirDrop                      > False