#!/bin/bash
# ------------------------------------------------------------------------------
# Script Name: enhanced_mdatp_pua.sh
# The script checks:
# 	1. If all required Defender processes are running
# 	2. If the mdatp command-line tool is available
# 	3. The current PUA policy configuration (audit/block/none)
#   4. Logs policy states for historical tracking
#
# Enhanced Microsoft Defender for Endpoint PUA (Potentially Unwanted Application) Check Script
# For use with Intune custom attribute script with policy state tracking and debug capability
#
# Purpose: 
#	- Verify Microsoft Defender for Endpoint is running properly
# 	- Determine how it's configured to handle Potentially Unwanted Applications
#   - Track policy state changes over time through historical logging
#   - Support Custom Attribute script for reporting in Intune
#
# Usage: 
#   - Standard mode: sudo ./enhanced_mdatp_pua.sh
#   - Debug mode:    sudo DEBUG=1 bash ./enhanced_mdatp_pua.sh
#
# Output: 
#   - A single line at the end for Intune custom attribute capture
#   - Historical logs of policy states for tracking changes
#   - Current policy state file for Custom Attribute script to track policy state
#
# Log Files:
#   - All logs are stored in /Library/Logs/Microsoft/IntuneScripts/mdatp/
#   - LOG_FILE: General script execution logs with INFO/WARNING/ERROR levels
#               (${SCRIPT_NAME}.log)
#   - ERROR_LOG_FILE: Records only error messages for easier troubleshooting
#                    (${SCRIPT_NAME}_error.log)
#   - POLICY_FILE: Historical record of all PUA policy states and changes
#                 (pua_policy.log)
#   - CURRENT_POLICY_FILE: Contains only the current PUA policy state for
#                         efficient reading by the Custom Attribute script
#                         (current_pua_policy.txt)
#   - Log rotation occurs when files exceed 1MB
#
# AUTHOR: Oktay Sari
# https://allthingscloud.blog
# https://github.com/oktay-sari/
#
# SCRIPT VERSION/HISTORY:
# 24-02-2025 - Oktay Sari - Script version 1.0 initial script
# 24-02-2025 - Oktay Sari - Script version 1.1 Add checks for mdatp tools and service check
# 24-02-2025 - Oktay Sari - Script version 1.2 Add extra logging and comments
# 24-02-2025 - Oktay Sari - Script version 1.3 Add debug mode
# 24-02-2025 - Oktay Sari - Script version 1.4 Add single line of output for Intune
# 27-02-2025 - Oktay Sari - Script version 1.5 Enhanced with policy state tracking and compatibility with Custom Attribute script
# 27-02-2025 - Oktay Sari - Script version 1.6 add Log rotation
# 28-02-2025 - Oktay Sari - Script version 2.0 Reorganized with modular functions   
#
# CREDITS:
# 	- The service check function was inspired by Neil Johnsons CheckDefenderRunning script:
#  	- https://github.com/microsoft/shell-intune-samples/blob/master/macOS/Custom%20Attributes/checkDefenderRunning/checkDefenderRunning.sh
#	- Original script idea to check for PUA status: Melvin Luijten
#	- Shout-out to Melvin Luijten for providing feedback and testing both scripts (https://www.linkedin.com/in/melvin-luijten-3973a6b1/)
#
# ------------------------------------------------------------------------------
# DISCLAIMER:
# This script is provided "as is" without warranties or guarantees of any kind. While it has been
# created to fulfill specific functions and has worked effectively for my personal requirements,
# its performance may vary in different environments or use-cases.
# Users are advised to employ this script at their own discretion and risk.
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages
# that may arise from its use.
#
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
# ------------------------------------------------------------------------------

# Check if debug mode is enabled (DEBUG=1)
DEBUG=${DEBUG:-0} # Leave this line as it is if you are using Intune! 

# When you want to troubleshoot manually, run the script with the command: sudo DEBUG=1 bash ./mdatp_pua.sh
# It will show all information on screen so you don't have to check the logfiles manually

# Define log directory and files
readonly LOG_DIR="/Library/Logs/Microsoft/IntuneScripts/mdatp"
readonly SCRIPT_NAME=$(basename "$0")
readonly LOG_FILE="$LOG_DIR/${SCRIPT_NAME%.*}.log"
readonly ERROR_LOG_FILE="$LOG_DIR/${SCRIPT_NAME%.*}_error.log"
readonly POLICY_FILE="$LOG_DIR/pua_policy.log"
readonly CURRENT_POLICY_FILE="$LOG_DIR/current_pua_policy.txt"

#-------------------------------------------------------------------------------
# Function: initialize_logs
# Purpose: Initialize log directory and handle log rotation
#-------------------------------------------------------------------------------
initialize_logs() {
    # Create log directory if it doesn't exist
    if [ ! -d "$LOG_DIR" ]; then
        mkdir -p "$LOG_DIR"
    fi
    
    # Rotate log files if they get too large (over 1MB)
    for logfile in "$LOG_FILE" "$ERROR_LOG_FILE" "$POLICY_FILE"; do
        if [ -f "$logfile" ] && [ $(stat -f%z "$logfile" 2>/dev/null || echo 0) -gt 1048576 ]; then
            mv "$logfile" "${logfile}.old"
        fi
    done
}

#-------------------------------------------------------------------------------
# Function: log
# Purpose: Enhanced logging function with severity levels
# Parameters:
#   $1 - Severity level (INFO, WARNING, ERROR)
#   $2 - Message to log
#-------------------------------------------------------------------------------
log() {
    local severity="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Log based on severity
    case "$severity" in
        INFO)
            echo "$timestamp - [INFO] $message" >> "$LOG_FILE"
            ;;
        WARNING)
            echo "$timestamp - [WARNING] $message" >> "$LOG_FILE"
            ;;
        ERROR)
            echo "$timestamp - [ERROR] $message" >> "$LOG_FILE"
            echo "$timestamp - [ERROR] $message" >> "$ERROR_LOG_FILE"
            ;;
        *)
            echo "$timestamp - [INFO] $message" >> "$LOG_FILE"
            ;;
    esac
    
    # If debug mode is enabled, also display to console
    if [ "$DEBUG" -eq 1 ]; then
        echo "[$severity] $message"
    fi
}

#-------------------------------------------------------------------------------
# Function: check_defender_processes
# Purpose: Check if required Defender processes are running
# Returns: 0 if all processes are running, 1 if not
#-------------------------------------------------------------------------------
check_defender_processes() {
    log "INFO" "Checking if Microsoft Defender for Endpoint processes are running"
    
    # Define list of processes that should be running for Microsoft Defender
    local processes=(
        "wdavdaemon_enterprise"
        "wdavdaemon_unprivileged"
        "wdavdaemon"
    )
    
    # Check each required process
    local missingProcCount=0
    for proc in "${processes[@]}"; do
        if ! pgrep -x "$proc" >/dev/null; then
            log "ERROR" "Process [$proc] is not running"
            let missingProcCount=$missingProcCount+1
        else
            log "INFO" "Process [$proc] is running"
        fi
    done
    
    # Evaluate process check results
    if [[ $missingProcCount -gt 0 ]]; then
        log "ERROR" "Microsoft Defender is missing [$missingProcCount] required processes"
        
        if [ "$DEBUG" -eq 1 ]; then
            echo "=== Enhanced MDATP Policy & Health Checker Failed: Defender Missing Processes ==="
        fi
        
        echo "DEFENDER_ERROR" > "$CURRENT_POLICY_FILE"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - [ERROR] Microsoft Defender is missing [$missingProcCount] required processes" >> "$POLICY_FILE"
        return 1
    fi
    
    log "INFO" "Microsoft Defender is running properly (all processes verified)"
    return 0
}

#-------------------------------------------------------------------------------
# Function: log_environment_info
# Purpose: Log environment information for troubleshooting
#-------------------------------------------------------------------------------
log_environment_info() {
    log "INFO" "Current user: $(whoami)"
    log "INFO" "PATH environment: $PATH"
}

#-------------------------------------------------------------------------------
# Function: find_mdatp_binary
# Purpose: Find the mdatp binary location
# Returns: 0 if mdatp is found, 1 if not
# Sets global variable MDATP_PATH
#-------------------------------------------------------------------------------
find_mdatp_binary() {
    MDATP_PATH=""
    
    log "INFO" "Searching for mdatp location..."
    local find_mdatp=$(which mdatp 2>/dev/null || echo "Not found in PATH")
    log "INFO" "mdatp location from which: $find_mdatp"
    
    # Check common locations
    local common_paths=(
        "/usr/local/bin/mdatp"
        "/usr/bin/mdatp"
        "/Library/Application Support/Microsoft/Defender/mdatp"
    )
    
    for path in "${common_paths[@]}"; do
        if [ -x "$path" ]; then
            log "INFO" "Found mdatp at: $path"
            MDATP_PATH="$path"
            break
        else
            log "INFO" "Checked $path - not found or not executable"
        fi
    done
    
    # If not found in common locations, try PATH as fallback
    if [ -z "$MDATP_PATH" ] && command -v mdatp &> /dev/null; then
        MDATP_PATH="mdatp"
        log "INFO" "Using mdatp from PATH"
    fi
    
    # Return success if we found it
    if [ -n "$MDATP_PATH" ]; then
        return 0
    else
        return 1
    fi
}

#-------------------------------------------------------------------------------
# Function: check_mdatp_availability
# Purpose: Check if mdatp command-line tool is available
# Uses global variable MDATP_PATH
# Returns: 0 if available, 1 if not
#-------------------------------------------------------------------------------
check_mdatp_availability() {
    log "INFO" "Checking for Microsoft Defender command-line tool (mdatp)"
    
    if [ -n "$MDATP_PATH" ] && [ -x "$MDATP_PATH" ]; then
        log "INFO" "Microsoft Defender command-line tool (mdatp) is available at $MDATP_PATH"
        return 0
    else
        if ! command -v mdatp &> /dev/null; then
            log "ERROR" "Microsoft Defender command-line tool (mdatp) is not available"
            
            if [ "$DEBUG" -eq 1 ]; then
                echo "=== Enhanced MDATP Policy & Health Checker Failed: mdatp Not Available ==="
            fi
            
            echo "MDATP_MISSING" > "$CURRENT_POLICY_FILE"
            echo "$(date +"%Y-%m-%d %H:%M:%S") - [ERROR] Microsoft Defender command-line tool (mdatp) is not available" >> "$POLICY_FILE"
            return 1
        else
            MDATP_PATH="mdatp"  # Use command from PATH as fallback
            log "INFO" "Using mdatp from PATH"
            return 0
        fi
    fi
}

#-------------------------------------------------------------------------------
# Function: get_threat_policy
# Purpose: Get the current threat policy
# Uses global variable MDATP_PATH
# Sets global variable PUACHECK
# Returns: 0 if successful, 1 if failed
#-------------------------------------------------------------------------------
get_threat_policy() {
    log "INFO" "Retrieving threat policy information"
    
    PUACHECK=$("$MDATP_PATH" threat policy list 2>&1)
    if [ $? -ne 0 ]; then
        log "ERROR" "Failed to retrieve threat policy information: $PUACHECK"
        
        if [ "$DEBUG" -eq 1 ]; then
            echo "=== Enhanced MDATP Policy & Health Checker Failed: Cannot Query Policy ==="
        fi
        
        echo "POLICY_ERROR" > "$CURRENT_POLICY_FILE"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - [ERROR] Failed to retrieve threat policy information: $PUACHECK" >> "$POLICY_FILE"
        return 1
    fi
    
    # Verify the command actually returned policy data
    if [[ -z "$PUACHECK" ]]; then
        log "WARNING" "Threat policy list returned empty result"
        
        if [ "$DEBUG" -eq 1 ]; then
            echo "=== Enhanced MDATP Policy & Health Checker Completed with Warnings ==="
        fi
        
        echo "EMPTY_POLICY" > "$CURRENT_POLICY_FILE"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - [WARNING] Threat policy list returned empty result" >> "$POLICY_FILE"
        return 1
    fi
    
    log "INFO" "Successfully retrieved threat policy information"
    return 0
}

#-------------------------------------------------------------------------------
# Function: analyze_pua_configuration
# Purpose: Analyze the PUA configuration from the threat policy
# Uses global variable PUACHECK
#-------------------------------------------------------------------------------
analyze_pua_configuration() {
    log "INFO" "Analyzing PUA configuration"
    
    if echo "$PUACHECK" | grep -q "Threat type: potentially_unwanted_application"; then
        # PUA policy exists, determine the action setting
        if echo "$PUACHECK" | grep -q "Action: audit"; then
            log "INFO" "PUA status: Audit (PUAs are detected but not blocked)"
            
            # Store for historical tracking
            echo "$(date +"%Y-%m-%d %H:%M:%S") - PUA_ACTION=audit" >> "$POLICY_FILE"
            echo "audit" > "$CURRENT_POLICY_FILE"
            
            if [ "$DEBUG" -eq 1 ]; then
                echo "=== Enhanced MDATP Policy & Health Checker Completed Successfully ==="
            fi
            
            echo "PASSED: PUA in Audit Mode"
            return 0
        elif echo "$PUACHECK" | grep -q "Action: block"; then
            log "INFO" "PUA status: Block (PUAs are actively blocked)"
            
            # Store for historical tracking
            echo "$(date +"%Y-%m-%d %H:%M:%S") - PUA_ACTION=block" >> "$POLICY_FILE"
            echo "block" > "$CURRENT_POLICY_FILE"
            
            if [ "$DEBUG" -eq 1 ]; then
                echo "=== Enhanced MDATP Policy & Health Checker Completed Successfully ==="
            fi
            
            echo "PASSED: PUA in Block Mode"
            return 0
        else
            log "WARNING" "PUA status: Unknown (policy exists but action is undefined)"
            
            # Store for historical tracking
            echo "$(date +"%Y-%m-%d %H:%M:%S") - PUA_ACTION=unknown" >> "$POLICY_FILE"
            echo "unknown" > "$CURRENT_POLICY_FILE"
            
            if [ "$DEBUG" -eq 1 ]; then
                echo "=== Enhanced MDATP Policy & Health Checker Completed with Warnings ==="
            fi
            
            echo "FAILED: PUA status Unknown"
            return 1
        fi
    else
        log "WARNING" "No PUA configuration found"
        
        # Store for historical tracking
        echo "$(date +"%Y-%m-%d %H:%M:%S") - [WARNING] No PUA configuration found" >> "$POLICY_FILE"
        echo "NOT_CONFIGURED" > "$CURRENT_POLICY_FILE"
        
        if [ "$DEBUG" -eq 1 ]; then
            echo "=== Enhanced MDATP Policy & Health Checker Completed with Warnings ==="
        fi
        
        echo "FAILED: PUA Not Configured"
        return 1
    fi
}

#-------------------------------------------------------------------------------
# Function: main
# Purpose: Main function to execute the script
#-------------------------------------------------------------------------------
main() {
    # Global variables to store shared data between functions
    MDATP_PATH=""
    PUACHECK=""
    
    # Start script execution
    if [ "$DEBUG" -eq 1 ]; then
        echo "=== Enhanced MDATP Policy & Health Checker Started ==="
    fi
    log "INFO" "Enhanced MDATP Policy & Health Checker started"
    
    # Initialize logs
    initialize_logs
    
    # Check Defender processes
    check_defender_processes
    if [ $? -ne 0 ]; then
        exit 1
    fi
    
    # Log environment information
    log_environment_info
    
    # Find mdatp binary
    find_mdatp_binary
    if [ $? -ne 0 ]; then
        if [ "$DEBUG" -eq 1 ]; then
            echo "=== Enhanced MDATP Policy & Health Checker Failed: mdatp Not Found ==="
        fi
        echo "MDATP_MISSING" > "$CURRENT_POLICY_FILE"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - [ERROR] Could not find mdatp binary" >> "$POLICY_FILE"
        exit 1
    fi
    
    # Check mdatp availability
    check_mdatp_availability
    if [ $? -ne 0 ]; then
        exit 1
    fi
    
    # Get threat policy
    get_threat_policy
    if [ $? -ne 0 ]; then
        exit 1
    fi
    
    # Analyze PUA configuration and exit with its status
    analyze_pua_configuration
    exit $?
}

# Execute main function
main