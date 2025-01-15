# CIS Benchmark - Custom Implementation

**Disable Wake for Network Access**

This configuration disables the ability for macOS devices to wake for network access, reducing risks of unauthorized remote access.

**Importance**  
This configuration enhances macOS security and aligns with CIS benchmarks. It helps mitigate potential vulnerabilities by implementing recommended settings.

**Key Points**  
- Implements recommended security settings to reduce risk.  
- Aligns with CIS or other hardening standards for macOS.  
- Supports organizational security policies and compliance efforts.

---
**disables Wake (me up..before you...)for LAN**

The "Wake for Network Access" feature allows a macOS device to wake from sleep mode to perform tasks, 
such as providing access to shared resources or responding to management tools. 
However, this capability exposes the device to potential risks, especially on untrusted networks, where malicious actors could send unauthorized wake signals.

**IMPACT**

Disabling this feature reduces the risk of remote attacks by preventing unauthorized users from waking the system and accessing its resources. 
However, turning off Wake for Network Access may **impact** certain functionalities. For example, management tools like **Apple Remote Desktop** will be unable to wake devices over the network. 
Services like **"Find My Mac"** will not function when the device is asleep. A **remote wipe** will also fail. 
This trade-off should be carefully considered in environments requiring remote management or device tracking.