## CIS Benchmark - Custom Implementation

This configuration profile is for screensaver settings


**Screensaver Settings: Enhance Security with Idle Time Protection**

Screensaver settings on macOS can be configured to secure devices during periods of inactivity, reducing the risk of unauthorized access. 
By enforcing a password prompt after the screensaver activates and setting idle time limits, organizations can ensure devices are protected when left unattended.

Summary of Settings and Values:
- Ask For Password Delay: 1 second
- Login Window Idle Time: 1200 seconds (20 minutes)
- Module Name: /System/Library/Screen Savers/Random.saver
- Ask For Password: True

These configurations ensure that a password is required shortly after the screensaver activates, while also enforcing a 20-minute idle time limit. 
Using the "Random" screensaver module adds variety, and these settings collectively enhance device security by mitigating risks from unattended systems.