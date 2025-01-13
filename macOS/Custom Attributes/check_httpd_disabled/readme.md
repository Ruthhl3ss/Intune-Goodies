**check_httpd_disabled.sh**

This script checks if the built-in HTTP server (Apache) on macOS is disabled and reports the result. It ensures that unused network services are not unintentionally active.

**Importance**  
Running unnecessary services like the HTTP server increases the system's attack surface. Verifying its status ensures a more secure configuration.

**Key Points**  
- Checks if the HTTP server (Apache) is disabled.  
- Reports 'HTTP server is disabled' if the service is not running.  
- Reports 'HTTP server is enabled' if the service is active.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).
