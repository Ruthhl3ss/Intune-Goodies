# Microsoft Defender PUA Policy Monitor for Intune

This folder contains two scripts that work together to monitor Microsoft Defender for Endpoint (MDATP) Potentially Unwanted Application (PUA) policy settings on macOS devices and report changes via Intune Custom Attributes.

## Purpose

These scripts were created to address a specific issue: PUA policy settings occasionally changing on devices without administrator intervention. This monitoring solution provides:

- Real-time visibility into the current PUA policy state on each device
- Detection and reporting of policy changes
- Historical tracking of when changes occurred
- Centralized reporting through Intune Custom Attributes

## Scripts Overview

### 1. Enhanced MDATP Policy Checker (`enhanced_mdatp_pua.sh`)

This script runs periodically to check the current PUA policy configuration and log the results.

**Key Features:**
- Verifies Microsoft Defender processes are running
- Locates and validates the MDATP command-line tool
- Retrieves the current PUA policy configuration
- Logs policy state changes with timestamps
- Comprehensive error handling

**Script History/Updates:**
- 24-02-2025 - Oktay Sari - Script version 1.0 initial script
- 24-02-2025 - Oktay Sari - Script version 1.1 Add checks for mdatp tools and service check
- 24-02-2025 - Oktay Sari - Script version 1.2 Add extra logging and comments
- 24-02-2025 - Oktay Sari - Script version 1.3 Add debug mode
- 24-02-2025 - Oktay Sari - Script version 1.4 Add single line of output for Intune
- 27-02-2025 - Oktay Sari - Script version 1.5 Enhanced with policy state tracking and compatibility with Custom Attribute script
- 27-02-2025 - Oktay Sari - Script version 1.6 add Log rotation
- 28-02-2025 - Oktay Sari - Script version 2.0 Reorganized with modular functions  

### 2. Custom Attribute Script (`mdatp_pua_custom_attribute.sh`)

This script reads the logs created by the first script and reports the information to Intune.

**Key Features:**
- Reads the current policy state
- Detects changes from previous state
- Maintains a counter of how many times the policy has changed
- Persistently tracks and reports policy changes even when the current state is stable
- Formats output for Intune Custom Attributes
- Reports when changes occurred
- Fallback mechanisms if primary data is unavailable

**Script History/Updates:**
- 27-02-2025 - Oktay Sari - Script version 1.0 initial script
- 28-02-2025 - Oktay Sari - Script version 1.1 Enhanced to show change dates and handle more states
- 28-02-2025 - Oktay Sari - Script version 1.2 Added special message when no log files exist yet
- 28-02-2025 - Oktay Sari - Script version 1.3 Added debug mode for easier testing
- 28-02-2025 - Oktay Sari - Script version 1.4 Fixed debug output to prevent it from mixing with regular output
- 05-03-2025 - Oktay Sari - Script version 1.5 Enhanced to persistently track policy changes and count occurrences (shout-out to Melvin Luijten for the feedback)

## Deployment Instructions

### Enhanced MDATP Policy Checker

1. Download `enhanced_mdatp_pua.sh` to your local machine
2. Deploy to your macOS devices using Intune Shell Scripts:
   - Navigate to Devices > macOS > Scripts
   - Create a new script with the following settings:
     - **Run script as signed-in user**: No
     - **Hide script notifications on devices**: YES
     - **Script frequency**: To your needs
     - **Max number of times to retry if script fails**: 3

### Custom Attribute Script

1. Download `mdatp_pua_custom_attribute.sh` to your local machine
2. Deploy as a Custom Attribute in Intune:
   - Navigate to Devices > macOS > Custom Attributes for macOS
   - Add a new Custom Attribute with the following settings:
     - **Name**: PUA Policy Reporter
     - **Description**: PUA Policy Reporter
     - **Data type of attribute**: String
     - **Sscript**: upload the `mdatp_pua_custom_attribute.sh` script

## How It Works

The two scripts work together in a complementary way:

1. **Enhanced MDATP Policy Checker**:
   - Runs every 15 minutes (or any other schedule you choose)
   - Checks the current Defender PUA policy
   - Logs the results to files in `/Library/Logs/Microsoft/IntuneScripts/mdatp/`

2. **Custom Attribute Script**:
   - Is executed by Intune when collecting device information (by default every 8 hours)
   - Reads the logs created by the first script
   - Tracks and maintains a history of policy changes
   - Reports the current policy state and any changes to Intune, including how many times changes have occurred

This separation allows the heavy-lifting (policy checking) to be done locally, while only the summarized results are reported to Intune.

## Log Files

All logs are stored in `/Library/Logs/Microsoft/IntuneScripts/mdatp/`:

| File | Description |
|------|-------------|
| `enhanced_mdatp_pua.log` or `bash.log` | Main log containing all INFO/WARNING/ERROR messages |
| `enhanced_mdatp_pua_error.log` | Error-only log for easier troubleshooting |
| `pua_policy.log` | Historical record of all policy states and changes |
| `current_pua_policy.txt` | Current policy state file (for efficient reading) |
| `previous_pua_state.txt` | Previous policy state (used by Custom Attribute script) |
| `last_policy_change.txt` | Records details of the most recent policy change |
| `policy_change_counter.txt` | Tracks how many times the policy has changed |

The scripts implement log rotation to prevent excessive disk usage. Files larger than 1MB are automatically renamed with a `.old` extension. There will be only 1 `.old` file for historical data.

## Debug Mode

Both scripts include a debug mode that can be activated by setting the DEBUG environment variable:

```bash
sudo DEBUG=1 bash ./enhanced_mdatp_pua.sh
sudo DEBUG=1 bash ./mdatp_pua_custom_attribute.sh
```

In debug mode, detailed information is printed to the console, showing each step of the script's execution. This is particularly useful for:

- Troubleshooting deployment issues
- Understanding how the scripts interact with Defender
- **Verifying proper execution on a specific device**

## Output Examples

### In Intune

The Custom Attribute script will report one of the following formats to Intune:

| Scenario | Output Example |
|----------|----------------|
| First run | `PUA_Policy=audit` |
| Policy change detected | `PUA_Policy=Changed from audit to block on 2025-02-28 count=1` |
| Previous change, to new change | `PUA_Policy=audit (Changed from block to audit on 2025-03-05 count=2)` |
| Change detectec but no new changes | `PUA_Policy=audit (Changed from block to audit on 2025-03-05 count=2)` |
| Unchanged policy (no changes ever detected) | `PUA_Policy=audit (unchanged since 2025-02-15)` |
| No logs exist yet | `PUA_Policy=No information available yet - MDATP checker has not run` |
| Error condition | `PUA_Policy=DEFENDER_ERROR` or `PUA_Policy=ERROR` |

These values appear in the Intune portal under Device > macOS > Custom attributes for macOS.

**Note**: Intune custom attributes update on Intune's collection schedule (typically every 8 hours). If you need to see updated values sooner, you can force a device sync 

### Local Log Output

The main log file contains entries like:

```
2025-02-28 20:44:04 - [INFO] Enhanced MDATP Policy & Health Checker started
2025-02-28 20:44:04 - [INFO] Checking if Microsoft Defender for Endpoint processes are running
2025-02-28 20:44:04 - [INFO] Process [wdavdaemon_enterprise] is running
2025-02-28 20:44:04 - [INFO] Process [wdavdaemon_unprivileged] is running
2025-02-28 20:44:04 - [INFO] Process [wdavdaemon] is running
2025-02-28 20:44:04 - [INFO] Microsoft Defender is running properly (all processes verified)
...
2025-02-28 20:44:04 - [INFO] PUA status: Audit (PUAs are detected but not blocked)
```

The policy history log contains entries like:

```
2025-02-15 10:30:45 - PUA_ACTION=audit
2025-02-20 14:22:10 - PUA_ACTION=block
2025-02-28 09:15:33 - PUA_ACTION=audit
```

The change tracking files contain information about the most recent change:

```
$ cat last_policy_change.txt
2025-03-05|block|audit

$ cat policy_change_counter.txt
2
```

## Troubleshooting

If you're not seeing Custom Attribute data in Intune:

1. Check if the Enhanced MDATP script is running:
   ```bash
   ls -la /Library/Logs/Microsoft/IntuneScripts/mdatp/
   ```

2. Verify the current policy file contains data:
   ```bash
   cat /Library/Logs/Microsoft/IntuneScripts/mdatp/current_pua_policy.txt
   ```

3. Check the change tracking files:
   ```bash
   cat /Library/Logs/Microsoft/IntuneScripts/mdatp/last_policy_change.txt
   cat /Library/Logs/Microsoft/IntuneScripts/mdatp/policy_change_counter.txt
   ```

4. Run the Custom Attribute script manually to see its output:
   ```bash
   sudo bash /path/to/mdatp_pua_custom_attribute.sh
   ```

5. If needed, run both scripts in debug mode to see detailed execution information:
   ```bash
   sudo DEBUG=1 bash /path/to/mdatp_pua_custom_attribute.sh
   ```

## Requirements

- macOS devices enrolled in Microsoft Intune
- Microsoft Defender for Endpoint installed
- Administrative privileges for script deployment