# Custom Attributes for macOS in Intune

This repository contains custom attribute scripts designed for managing macOS devices through **Microsoft Intune**. These scripts help administrators collect additional data about macOS devices, enabling advanced management and monitoring scenarios.

# Note
While most of the scripts are my own, some of them are saved here from other repositories for my own (and perhaps yours) convenience. However, collected scripts will always have the original authors name in the script. Some of the scripts originate from https://github.com/microsoft/shell-intune-samples/tree/master/macOS . These (forked) files can be found in the subdirectory "forked"

## ⚠️ Disclaimer
**Important:** The scripts in this repository are provided as a starting point and should be tested thoroughly in a **non-production environment** before deployment. Misuse or incorrect application of these scripts may lead to unintended results, including data inaccuracies, performance issues, or device instability.

It is your responsibility to:
- Review and understand each script's functionality.
- Test all scripts in a controlled environment.
- Modify the scripts to meet your organization's specific requirements.
- Validate the results after deployment to ensure accurate data collection.

**By using these scripts, you accept full responsibility for any impact on your environment.**

## What are Custom Attributes in Intune?
Custom attributes allow organizations to collect data from devices that are not available natively within Microsoft Intune. For macOS devices, these attributes can provide insights into system configuration, compliance status, application presence, and more.

## Features
- **Ready-to-Use Scripts:** Pre-written scripts to collect common macOS attributes, such as installed applications, disk usage, and system settings.
- **Customizable:** Modify the scripts to gather additional or specific data required by your organization.
- **Seamless Integration:** Designed to be deployed through **Microsoft Intune** for streamlined device management.

## Credits  
- some of these scripts are from sourced from https://github.com/microsoft/shell-intune-samples/tree/master/macOS and created by Neil Johson.

