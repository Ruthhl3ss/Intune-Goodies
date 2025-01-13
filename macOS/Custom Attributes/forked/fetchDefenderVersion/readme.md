**fetchDefenderVersion.sh**

This script checks for the installed version of Microsoft Defender on macOS and reports the result. It reads the application’s version information from its `Info.plist` file.

**Importance**  
Monitoring the installed version of Microsoft Defender helps ensure that the software is up to date with the latest security patches and features.

**Key Points**  
- Checks the `Info.plist` file for the `CFBundleShortVersionString` attribute.  
- Reports the version number if Microsoft Defender is installed.  
- Reports "not installed" if Microsoft Defender is not found.

---

**Note**  
Shell scripts provided in custom attribute profiles are run every 8 hours on managed Macs and reported.  
For more information, see [Custom attributes for macOS](https://learn.microsoft.com/en-us/mem/intune/apps/macos-shell-scripts#custom-attributes-for-macos).

Original script: https://github.com/microsoft/shell-intune-samples/tree/master/macOS