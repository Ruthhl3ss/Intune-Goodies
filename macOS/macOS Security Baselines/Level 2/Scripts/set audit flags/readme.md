# macOS Audit Flags Configuration Script

## ⚠️ CRITICAL WARNING - USE AT YOUR OWN RISK

This script modifies core system audit settings and service configurations. Improper deployment or configuration could result in:
- System boot failures
- Security audit subsystem malfunction
- System stability issues
- Potential need for system recovery or reinstallation

**REQUIRED PRECAUTIONS:**
1. **ALWAYS** test thoroughly in a controlled environment first (**start manually with 1 device**)
2. Create a system backup before testing if possible
3. Validate the audit configuration requirements for your environment
4. Have a recovery plan in place before deployment (see troubleshooting steps below)
5. Consider **staged rollout** in production environments

**DO NOT** deploy this script in production without proper testing and validation.
ß
## Overview
This Bash script will configure macOS security auditing flags to meet CIS recommendation **3.2 Ensure Security Auditing Flags**

## What This Script Does

The script configures specific security auditing flags on macOS devices by modifying the `/etc/security/audit_control` file. The following audit flags are set:

- **`-fm`**: file attribute modify (Record failed events)
- **`ad`**: Administrative actions
- **`-ex`**: program execution (Record failed events)
- **`aa`**: authentication and authorization
- **`-fr`**: file read (Record failed events)
- **`lo`**: Login/logout events
- **`-fw`**: file write (Record failed events)


## ⚠️ HIGH IMPACT

- **Can fill disk space rapidly**
- **May cause system slowdowns**
- **Could impact application performance**
- **Increases overall system load**
- systems perform thousands of file operations per minute
- Multiple users or services generate many authentication events
- Administrative tasks often involve numerous sub-operations
- Each logged event can includes metadata (timestamps, user info, process details)

That's why proper retention settings and log rotation are crucial when these flags are enabled.

## Important Notice

⚠️ **DEPRECATION NOTICE**: The audit(4) subsystem has been deprecated since macOS 11.0, disabled since macOS 14.0, and **WILL BE REMOVED** in a future version of macOS. Applications that require a security event stream should use the EndpointSecurity API instead.

On macOS 15 and later, you can re-enable audit(4) by:
1. Renaming or copying `/etc/security/audit_control.example` to `/etc/security/audit_control`
2. Re-enabling the system/com.apple.auditd service by running `launchctl enable system/com.apple.auditd` as root
3. Rebooting the system

Despite its deprecated status, the macOS audit subsystem (auditd) continues to be recommended by CIS Benchmarks as it currently is the only native macOS solution for comprehensive system auditing and logging. 

## How to Deploy

This script is designed for deployment via **Microsoft Intune**. Follow the steps below to deploy the script to managed macOS devices.

### Prerequisites

- Ensure you have **Microsoft Intune** set up for managing macOS devices.
- Devices must be enrolled and compliant with your organization's Intune policies.
- Devices must be supervised

### Deployment Steps

1. **Download the Script**
   - Clone this repository or download the `configure_audit_flags.sh` script.

2. **Upload Script to Intune**
   - Log into the [Microsoft Intune Admin Center](https://endpoint.microsoft.com/).
   - Navigate to **Devices** > **macOS** > **Scripts**.
   - Click **Add** > **Add Script**.
   - Provide a name (e.g., "Configure macOS Audit Flags").
   - Upload the `configure_audit_flags.sh` script file.

3. **Configure Script Settings**
   - Set **Run script as signed-in user** to **No** (requires admin privileges).
   - Set **Hide script notifications on devices** based on your preference. I recommend to set this to **Yes**
   - Set **Script frequency** based on your preference or **Every 1 week**
   - Set **Max number of times to retry if script fails** to  **3 times**
   
4. **Assign the Script**
   - Assign the script to the appropriate **device groups**.
   - **NOTE:** Consider staged rollout!

5. **Monitor Deployment**
   - After deployment, monitor the script's execution

### Verification

After deployment, you can verify that the audit flags are correctly applied by running the following command on a managed macOS device:

```bash
sudo grep '^flags:' /etc/security/audit_control
```

You should see the following output:

```
flags: -fm,ad,-ex,aa,-fr,lo,-fw
```

## Script Features

- Sets audit flags according to CIS Benchmark recommendations
- Creates audit_control file from example if it doesn't exist
- Handles cases where the flags line doesn't exist
- Implements atomic operations for file modifications
- Maintains secure backups with rotation (keeps last 5 by default)
- Provides comprehensive logging
- Uses file locking to prevent concurrent execution
- Validates settings and file permissions
- Compatible with bash 3 (default macOS shell)
- Manages auditd service state

## Default Audit Flags

The script sets the following audit flags:
```bash
-fm,ad,-ex,aa,-fr,lo,-fw
```

## Prerequisites

- macOS operating system
- Root privileges
- Sufficient disk space for log files and backups

## Manual testing

1. Download the script to your preferred location
2. Make it executable:
   ```bash
   chmod +x set_audit_flags.sh
   ```

## Usage

Run the script with root privileges:

```bash
sudo ./set_audit_flags.sh
```

When deployed via Microsoft Intune, the script will run with the necessary privileges automatically.

## Configuration

The script uses several configurable constants:

```bash
readonly AUDIT_CONTROL_PATH="/etc/security/audit_control"
readonly LOG_DIR="/Library/Logs/Microsoft/IntuneScripts/audit"
readonly REQUIRED_FLAGS="-fm,ad,-ex,aa,-fr,lo,-fw"
readonly MAX_BACKUPS=5
```

- `AUDIT_CONTROL_PATH`: Path to the audit control file
- `LOG_DIR`: Directory for script logs
- `REQUIRED_FLAGS`: Desired audit flags
- `MAX_BACKUPS`: Maximum number of backup files to keep

## Logging

The script creates detailed logs at:
```
/Library/Logs/Microsoft/IntuneScripts/audit/audit_flags_config.log
```

Log files are automatically rotated when they exceed 10MB.

## Security Features

- Uses atomic operations for file modifications
- Implements secure file permissions
- Verifies backup integrity before making changes
- Uses file locking to prevent concurrent execution
- Validates all settings before applying
- Maintains audit trail through logging
- Uses restrictive umask (027)

## File Permissions

The script sets the following permissions:

- Audit Control File: `400` (read-only for root)
- Log Directory: `755` (world-readable, but only writable by root)
- Temporary Files: Created with `umask 027`

## Service Management

The script:
- Checks if auditd service file exists
- Verifies service state
- Attempts to start service if needed
- Retries service start with exponential backoff
- Logs all service-related operations

## Troubleshooting

Common issues and solutions:

1. **Permission Denied**
   - Ensure the script is run with root privileges
   - Check file permissions on the audit_control file

2. **File Not Found**
   - Verify that audit_control.example exists
   - Check paths in script constants

3. **Service Issues**
   - Check if auditd.plist exists
   - Verify service state with `launchctl print system/com.apple.auditd`
   - Check system logs for service errors

4. **Lock File Issues**
   - Remove stale lock file: `sudo rm -rf /var/run/audit_flags_config.lock`
   - Check for other running instances

5. **SYSTEM RESTORE OPTIONS**
   - If you are here, you can start by following the steps below 
   - create a script that will restore the original audit_control file by using audit_control.example
   - script should also disable auditd service
   - deploy script using Intune
   - unassign any other script that manipulates audit_control file
   - pray...

## Contributing

If you think you have a good idea to further enhance this script, please reach out or submit a Pull Request.


## Disclaimer

While this script has been created to fulfill specific functions and has worked effectively for personal requirements, its performance may vary in different environments or use-cases. Users are advised to employ this script at their own discretion and risk. No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.

**ALWAYS TEST in a controlled environment before deploying in production!**

## Version History

- 22-02-2025 v1.2 - Add service_path check to see if auditd is present on system
- 21-02-2025 v1.1 - Build script based on retention script
- 20-02-2025 v1.0 - Initial script
