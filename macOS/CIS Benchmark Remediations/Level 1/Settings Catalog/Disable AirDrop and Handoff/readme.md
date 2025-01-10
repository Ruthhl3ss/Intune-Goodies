## CIS Benchmark - Custom Implementation

This configuration profile Ensures AirDrop Is Disabled When Not Actively Transferring Files. 

AirDrop is super handy for sharing files between Apple devices, but leaving it on all the time can expose your device to privacy risks and unwanted file requests. The best practice? Keep it off by default and only switch it on when you actually need to send or receive files.

AirPlay Receiver, which lets you share your screen with other Apple devices, is another great feature—but it’s better to use it only when needed. Leaving it on all the time could lead to misuse or even denial-of-service issues. By setting up configuration profiles, you can easily keep these features off by default and stay secure.

**Configured items:**

- Allow Air Play Incoming Requests   > Disabled
- Allow Activity Continuation        > False
- Allow AirDrop                      > False

