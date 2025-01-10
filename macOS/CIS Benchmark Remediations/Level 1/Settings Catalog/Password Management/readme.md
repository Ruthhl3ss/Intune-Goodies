## CIS Benchmark - Custom Implementation

**Password Management: Keep It Secure, Keep It Practical**

**HIGH IMPACT:** Make sure "Change At Next Auth" is disabled. Check this configuration before deploying it. 
If you do not configure this setting, every user on the device MUST RESET their password at next logon!

**NOTE:** Make sure to test this policy in combination with Platform SSO. 
Do not set these settings in a compliance policy because that will always trigger a password change. 
a passcode setting in a compliance policy **always sets the "Change At Next Auth" to true.**