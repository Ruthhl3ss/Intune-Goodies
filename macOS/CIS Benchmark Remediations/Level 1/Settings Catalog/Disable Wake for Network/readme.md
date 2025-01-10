## CIS Benchmark - Custom Implementation

This configuration profile disables the guest account

**Note:**

The "Wake for Network Access" feature allows a macOS device to wake from sleep mode to perform tasks, 
such as providing access to shared resources or responding to management tools. 
However, this capability exposes the device to potential risks, especially on untrusted networks, where malicious actors could send unauthorized wake signals.

**IMPACT**
Disabling this feature reduces the risk of remote attacks by preventing unauthorized users from waking the system and accessing its resources. 
However, turning off Wake for Network Access may **impact** certain functionalities. For example, management tools like **Apple Remote Desktop** will be unable to wake devices over the network. 
Services like **"Find My Mac"** will not function when the device is asleep. A **remote wipe** will also fail. 
This trade-off should be carefully considered in environments requiring remote management or device tracking.