# CIS Benchmark - Custom Implementation

**Enforce Password Management Policies**

This configuration enforces secure password policies, ensuring that user passwords meet organizational security standards.

**Importance**  
This configuration enhances macOS security and aligns with CIS benchmarks. It helps mitigate potential vulnerabilities by implementing recommended settings.

**Key Points**  
- Implements recommended security settings to reduce risk.  
- Aligns with CIS or other hardening standards for macOS.  
- Supports organizational security policies and compliance efforts.

---

**Password Management: Keep It Secure, Keep It Practical**

**HIGH IMPACT:** Make sure "Change At Next Auth" is disabled. Check this configuration before deploying it. 
If you do not configure this setting, every user on the device MUST RESET their password at next logon!

**NOTE:** Make sure to test this policy in combination with Platform SSO. 
Do not set these settings in a compliance policy because that will always trigger a password change. 
a passcode setting in a compliance policy **always sets the "Change At Next Auth" to true.**