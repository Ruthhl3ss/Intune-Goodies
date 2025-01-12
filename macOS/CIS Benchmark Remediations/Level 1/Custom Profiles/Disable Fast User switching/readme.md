## CIS Benchmark - Custom Implementation

This configuration improves security on macOS by disabling **Fast User Switching**, which prevents other users from accessing an active and locked session. 
This helps ensure that only the current user can unlock their session, even if an administrator tries to access it.  

At the same time, the setup keeps **Touch ID** functional, allowing users to unlock their devices quickly—while still maintaining security by limiting access to the active user’s session only.  

**Why disable fast userswitcing?** 
Fast User Switching might seem convenient, but it can create vulnerabilities by allowing others to log in without fully ending the current session. 
Disabling this feature ensures that each user’s session is fully secure, minimizing the risk of unauthorized access.  

With Touch ID support preserved, this solution strikes a balance between strong security and a smooth user experience.  

**Key config points**  
- **Fast User Switching Disabled**: Prevents unauthorized access to active sessions.  
- **Touch ID Enabled**: Keeps device unlocking fast and easy for the active user.  
- **Better Security**: Ensures compliance with best practices while reducing risks of session hijacking.  

Ideal for organizations or users who prioritize security without sacrificing convenience.

