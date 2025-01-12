## CIS Benchmark - Custom Implementation

**macOS - Hardening - Safari Security and Privacy Configuration**

This configuration enhances the security and privacy settings of Safari, macOS's built-in web browser, by applying recommended controls. 
These settings mitigate risks related to unsafe downloads, tracking, and data storage, ensuring safer browsing and reduced exposure to potential threats.  

**Why It’s Important**  
Web browsers are common entry points for security threats, including malicious downloads, fraudulent websites, and invasive tracking mechanisms. By implementing stricter controls, organizations can reduce these risks while maintaining functionality for users. These settings prioritize user safety, limit data exposure, and enhance transparency during browsing.  

**Key Points**
- **AutoOpenSafeDownloads**: `False`  
  Prevents Safari from automatically opening downloaded files, reducing exposure to malicious content.  
- **BlockStoragePolicy**: `2`  
  Restricts website data storage to enhance privacy and reduce tracking.  
- **ShowFullURLInSmartSearchField**: `True`  
  Displays the full URL in the address bar, improving transparency and user awareness.  
- **ShowOverlayStatusBar**: `True`  
  Enables the overlay status bar to provide additional browsing context.  
- **WarnAboutFraudulentWebsites**: `True`  
  Activates warnings for potentially fraudulent or harmful websites to protect users.  
- **Private Click Measurement**: `True`  
  Enables privacy-focused click tracking to reduce invasive user tracking.  
- **WebKit Storage Blocking Policies**: `1`  
  Implements stricter storage blocking policies to enhance privacy and limit cross-site tracking.  

## Important Note  
These configurations are intended to improve browser security and privacy without significantly impacting user experience. 
However, organizations should communicate these changes to users and provide guidance on any new behaviors or limitations they may encounter.  

This setup is recommended for environments where secure and privacy-aware browsing is a priority.





