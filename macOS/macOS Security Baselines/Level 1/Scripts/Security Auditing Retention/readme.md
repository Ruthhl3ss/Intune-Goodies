# CIS Benchmark - Custom Implementation

**macOS - Hardening - Ensure Security Auditing Retention Is Enabled**

This configuration ensures that security audit logs are retained for an extended period, supporting compliance and investigation needs.

**Importance**  
Enabling security audit retention helps organizations track system activity, detect anomalies, and support forensic investigations.

**Key Points**  
- Retains security audit logs for compliance and accountability.  
- Provides valuable insights for detecting and responding to incidents.  
- Aligns with CIS Level 1 benchmarks for macOS security.  



This configuration is critical for maintaining a comprehensive audit trail.


# macOS Audit Retention Configuration Script

This script configures and manages the audit retention settings in the macOS audit subsystem by modifying the audit_control file. It implements the CIS Benchmark recommendation 3.4 regarding Security Auditing Retention settings.

## Important Notice

⚠️ **DEPRECATION NOTICE**: The audit(4) subsystem has been deprecated since macOS 11.0, disabled since macOS 14.0, and WILL BE REMOVED in a future version of macOS. Applications that require a security event stream should use the EndpointSecurity(7) API instead.

On macOS 15 and later, you can re-enable audit(4) by:
1. Renaming or copying `/etc/security/audit_control.example` to `/etc/security/audit_control`
2. Re-enabling the system/com.apple.auditd service by running `launchctl enable system/com.apple.auditd` as root
3. Rebooting the system

## Features

- Configures audit retention settings according to CIS Benchmark recommendations
- Implements atomic operations for file modifications
- Maintains secure backups with rotation
- Provides comprehensive logging
- Uses file locking to prevent concurrent execution
- Validates settings and file permissions
- Handles cases where the retention setting doesn't exist

## Prerequisites

- macOS operating system
- Root privileges
- Sufficient disk space for log files and backups

## Installation

1. Download the script to your preferred location
2. Make it executable:
   ```bash
   chmod +x set_audit_retention.sh
   ```

## Usage

Run the script with root privileges:

```bash
sudo ./set_audit_retention.sh
```

## Intune
## When deployed via Microsoft Intune, the script will run with the necessary privileges automatically.
## Script Settings  
- **Run script as signed-in user**: No  
- **Hide script notifications on devices**: Yes  
- **Script frequency**: Not configured *(Got admin users roaming freely? Run this script more often, like every day, to keep things locked down tight!)*  
- **Number of times to retry if script fails**: 3  

## Configuration

The script uses several configurable constants:

```bash
readonly AUDIT_CONTROL_PATH="/etc/security/audit_control"
readonly LOG_DIR="/Library/Logs/Microsoft/IntuneScripts/audit"
readonly DESIRED_RETENTION_SETTING="60d OR 5G"
readonly MAX_BACKUPS=5
```

- `AUDIT_CONTROL_PATH`: Path to the audit control file
- `LOG_DIR`: Directory for script logs
- `DESIRED_RETENTION_SETTING`: Desired retention period and size
- `MAX_BACKUPS`: Maximum number of backup files to keep

## Logging

The script creates detailed logs at:
```
/Library/Logs/Microsoft/IntuneScripts/audit/audit_retention_config.log
```

Log files are automatically rotated when they exceed 10MB.

## Security Features

- Uses atomic operations for file modifications
- Implements secure file permissions
- Verifies backup integrity
- Uses file locking to prevent concurrent execution
- Validates all settings before applying
- Maintains audit trail through logging

## File Permissions

The script sets the following permissions:

- Audit Control File: `400` (read-only for root)
- Log Directory: `755` (world-readable, but only writable by root)
- Temporary Files: Created with `umask 027`

## Error Handling

The script implements comprehensive error handling:
- Validates all inputs
- Verifies file operations
- Checks file permissions
- Maintains atomic operations
- Cleans up temporary files
- Provides detailed error messages in logs

## Backup Management

The script:
- Creates backups before making changes
- Verifies backup integrity
- Rotates old backups (keeps last 5 by default)
- Only creates backups when changes are needed

## Limitations

- Only modifies retention settings, does not enable/disable the audit subsystem
- Does not handle audit flags or other audit configurations
- Requires root privileges
- macOS specific, not compatible with other Unix-like systems

## Troubleshooting

Common issues and solutions:

1. **Permission Denied**
   - Ensure the script is run with root privileges
   - Check file permissions on the audit_control file

2. **File Not Found**
   - Verify that audit_control.example exists
   - Check paths in script constants

3. **Lock File Issues**
   - Remove stale lock file: `sudo rm -rf /var/run/audit_retention_config.lock`
   - Check for other running instances

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

## Disclaimer

While this script has been created to fulfill specific functions and has worked effectively for personal requirements, its performance may vary in different environments or use-cases. Users are advised to employ this script at their own discretion and risk. No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.

**ALWAYS TEST in a controlled environment before deploying in production!**

## Version History

- 04-02-2025 - Oktay Sari - Script version 1.0 initial script
- 08-02-2025 - Oktay Sari - Script version 1.1 move backup to update function
- 12-02-2025 - Oktay Sari - Script version 1.2 add lock file
- 15-02-2025 - Oktay Sari - Script version 1.3 add readonly variables
- 19-02-2025 - Oktay Sari - Script version 1.4 add enhanced logging
- 22-02-2025 - Oktay Sari - Script version 1.5 add secure backup rotation
- 23-02-2025 - Oktay Sari - Script version 1.6 handle the case where the expire-after line doesn't exist in the audit_control file.
