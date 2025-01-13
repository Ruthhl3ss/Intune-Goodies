**CheckGatekeeperStatus.zsh**

This script checks if Gatekeeper, macOS's application security feature, is enabled and reports the result.

**Importance**  
Gatekeeper ensures that only trusted applications are allowed to run, protecting the system from unverified and potentially harmful software.

**Key Points**  
- Checks if Gatekeeper is enabled.  
- Reports 'Gatekeeper is enabled' if the feature is active.  
- Reports 'Gatekeeper is disabled' if the feature is inactive.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS