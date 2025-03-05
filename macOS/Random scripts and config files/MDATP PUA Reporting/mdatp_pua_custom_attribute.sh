#!/bin/bash
# ------------------------------------------------------------------------------
# Script Name: mdatp_pua_custom_attribute.sh
# The script provides:
# 	1. Detection of Microsoft Defender PUA policy changes
# 	2. Tracking of when policy changes occurred
# 	3. Formatted output for Intune Custom Attributes
#
# Microsoft Defender for Endpoint PUA (Potentially Unwanted Application) Custom Attribute Script
# For use with Intune to report PUA policy status and changes as a Custom Attribute
#
# Purpose: 
#	- Read PUA policy information stored by the enhanced_mdatp_pua.sh script
# 	- Compare current policy with previous policy to detect changes
#   - Track when policy changes have occurred
#   - Format output specifically for Intune Custom Attributes
#
# Usage: 
#   - Standard mode: sudo ./mdatp_pua_attribute.sh
#   - Debug mode:    sudo DEBUG=1 bash ./mdatp_pua_custom_attribute.sh
#
# Output: 
#   - A single line with the PUA policy state formatted for Intune Custom Attributes
#   - Example: "PUA_Policy=audit" or "PUA_Policy=Changed from audit to block on 2025-02-28 count=1"
#
# Required Files:
#   - This script expects files created by the enhanced_mdatp_pua.sh script
#   - All files are read from /Library/Logs/Microsoft/IntuneScripts/mdatp/
#   - CURRENT_POLICY_FILE: Contains the current PUA policy state 
#                         (current_pua_policy.txt)
#   - POLICY_FILE: Used as a fallback if current policy file is unavailable
#                 (pua_policy.log)
#   - PREVIOUS_STATE_FILE: Stores the previous policy state for change detection
#                         (previous_pua_state.txt)
#   - CHANGE_FILE: Records the last detected policy change details
#                 (last_policy_change.txt)
#   - COUNTER_FILE: Tracks how many times the policy has changed
#                  (policy_change_counter.txt)
#
# AUTHOR: Oktay Sari
# https://allthingscloud.blog
# https://github.com/oktay-sari/
#
# SCRIPT VERSION/HISTORY:
# 27-02-2025 - Oktay Sari - Script version 1.0 initial script
# 28-02-2025 - Oktay Sari - Script version 1.1 Enhanced to show change dates and handle more states
# 28-02-2025 - Oktay Sari - Script version 1.2 Added special message when no log files exist yet
# 28-02-2025 - Oktay Sari - Script version 1.3 Added debug mode for easier testing
# 28-02-2025 - Oktay Sari - Script version 1.4 Fixed debug output to prevent it from mixing with regular output
# 05-03-2025 - Oktay Sari - Script version 1.5 Enhanced to persistently track policy changes and count occurrences (shout-out to Melvin Luijten for the feedback)
#
# CREDITS:
# 	- Designed to work with the enhanced_mdatp_pua.sh script for Microsoft Defender
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
DEBUG=${DEBUG:-0}

# Define file paths
readonly LOG_DIR="/Library/Logs/Microsoft/IntuneScripts/mdatp"
readonly POLICY_FILE="$LOG_DIR/pua_policy.log"
readonly CURRENT_POLICY_FILE="$LOG_DIR/current_pua_policy.txt"
readonly PREVIOUS_STATE_FILE="$LOG_DIR/previous_pua_state.txt"
readonly CHANGE_FILE="$LOG_DIR/last_policy_change.txt"
readonly COUNTER_FILE="$LOG_DIR/policy_change_counter.txt"

# Function definitions
# -----------------------------------------------------------------------------

# Simple debug function to output messages when in debug mode
# Sends debug messages to stderr so they don't get captured in command substitution
debug() {
    if [ "$DEBUG" -eq 1 ]; then
        echo "[DEBUG] $1" >&2
    fi
}

# Check if any log files exist yet
check_if_logs_exist() {
    debug "Checking if log directory exists at: $LOG_DIR"
    # Check if the log directory exists
    if [ ! -d "$LOG_DIR" ]; then
        debug "Log directory does not exist"
        return 1
    fi
    
    debug "Checking if log files exist: $POLICY_FILE and $CURRENT_POLICY_FILE"
    # Check if any of the MDATP log files exist
    if [ ! -f "$POLICY_FILE" ] && [ ! -f "$CURRENT_POLICY_FILE" ]; then
        # No logs from the enhanced script exist yet
        debug "No log files found - MDATP checker has not run yet"
        return 1
    fi
    
    # Logs exist
    debug "Log files found - MDATP checker has run"
    return 0
}

# Function to get current PUA action from current policy file
get_current_pua_state() {
    debug "Attempting to get current PUA state"
    
    # First check if the current policy file exists and has content
    if [ -f "$CURRENT_POLICY_FILE" ] && [ -s "$CURRENT_POLICY_FILE" ]; then
        local current_state=$(cat "$CURRENT_POLICY_FILE")
        debug "Found current policy file with state: $current_state"
        echo "$current_state"
        return
    fi
    
    debug "Current policy file not found, checking policy log file"
    
    # Fallback to parsing the log file if current policy file is unavailable
    if [ ! -f "$POLICY_FILE" ]; then
        debug "Policy log file not found, returning NOT_CONFIGURED"
        echo "NOT_CONFIGURED"
        return
    fi
    
    # Extract the PUA_ACTION value from the log file
    debug "Searching policy log file for PUA_ACTION entries"
    local action_line=$(grep "PUA_ACTION=" "$POLICY_FILE" | tail -1)
    
    if [ -n "$action_line" ]; then
        local extracted_state=$(echo "$action_line" | sed 's/.*PUA_ACTION=//')
        debug "Found PUA_ACTION in log: $extracted_state"
        echo "$extracted_state"
    else
        debug "No PUA_ACTION found, checking for error conditions"
        # Check for error conditions
        if grep -q "\[ERROR\]" "$POLICY_FILE"; then
            debug "Found ERROR entries in log file"
            echo "ERROR"
        elif grep -q "\[WARNING\]" "$POLICY_FILE"; then
            debug "Found WARNING entries in log file"
            if grep -q "No PUA configuration found" "$POLICY_FILE"; then
                debug "Log indicates no PUA configuration found"
                echo "NOT_CONFIGURED"
            else
                debug "Unknown warning condition"
                echo "UNKNOWN"
            fi
        else
            debug "No recognizable status in log file"
            echo "UNKNOWN"
        fi
    fi
}

# Function to track policy changes and maintain counter
track_policy_change() {
    local current_state="$1"
    local previous_state="$2"
    
    debug "Tracking policy change from $previous_state to $current_state"
    
    # Create log directory if it doesn't exist
    if [ ! -d "$LOG_DIR" ]; then
        mkdir -p "$LOG_DIR"
    fi
    
    # Record the current date and the change details
    echo "$(date '+%Y-%m-%d')|$previous_state|$current_state" > "$CHANGE_FILE"
    
    # Update counter
    if [ -f "$COUNTER_FILE" ] && [ -s "$COUNTER_FILE" ]; then
        local current_count=$(cat "$COUNTER_FILE")
        local new_count=$((current_count + 1))
        echo "$new_count" > "$COUNTER_FILE"
        debug "Incrementing change counter to $new_count"
    else
        # First change detected
        echo "1" > "$COUNTER_FILE"
        debug "Initializing change counter to 1"
    fi
}

# Function to read the last policy change information
get_last_policy_change() {
    if [ -f "$CHANGE_FILE" ] && [ -s "$CHANGE_FILE" ]; then
        cat "$CHANGE_FILE"
        return 0
    fi
    
    # No change record exists
    return 1
}

# Function to get the change counter
get_change_counter() {
    if [ -f "$COUNTER_FILE" ] && [ -s "$COUNTER_FILE" ]; then
        cat "$COUNTER_FILE"
    else
        echo "0"
    fi
}

# Main script execution
# -----------------------------------------------------------------------------

if [ "$DEBUG" -eq 1 ]; then
    echo "=== MDATP Custom Attribute Script Started (Debug Mode) ===" >&2
    debug "Script version 1.5"
    debug "Checking for MDATP log files"
fi

# First check if any logs exist yet
if ! check_if_logs_exist; then
    debug "No logs exist yet, outputting 'No information available' message"
    echo "PUA_Policy=No information available yet - MDATP checker has not run"
    
    if [ "$DEBUG" -eq 1 ]; then
        echo "=== MDATP Custom Attribute Script Completed ===" >&2
    fi
    
    exit 0
fi

# Get current PUA state
CURRENT_STATE=$(get_current_pua_state)
debug "Current PUA state: $CURRENT_STATE"

# Get previous state if available
if [ -f "$PREVIOUS_STATE_FILE" ]; then
    PREVIOUS_STATE=$(cat "$PREVIOUS_STATE_FILE")
    debug "Previous state found: $PREVIOUS_STATE"
else
    PREVIOUS_STATE="INITIAL_CHECK"
    debug "No previous state file, using INITIAL_CHECK"
fi

# Store current state for future comparison
debug "Storing current state for future comparison"
echo "$CURRENT_STATE" > "$PREVIOUS_STATE_FILE"

# Format output for Intune Custom Attribute
debug "Formatting output for Intune Custom Attribute"
if [ "$PREVIOUS_STATE" = "INITIAL_CHECK" ]; then
    debug "Initial check - reporting current state only"
    echo "PUA_Policy=$CURRENT_STATE"
elif [ "$CURRENT_STATE" != "$PREVIOUS_STATE" ]; then
    debug "State change detected - reporting change"
    # Record this change for future reference
    track_policy_change "$CURRENT_STATE" "$PREVIOUS_STATE"
    counter=$(get_change_counter)
    echo "PUA_Policy=Changed from $PREVIOUS_STATE to $CURRENT_STATE on $(date '+%Y-%m-%d') count=$counter"
else
    # Check if there was a previous change recorded
    if get_last_policy_change > /dev/null; then
        # There was a change in the past, report it along with current state
        change_info=$(get_last_policy_change)
        change_date=$(echo "$change_info" | cut -d'|' -f1)
        old_state=$(echo "$change_info" | cut -d'|' -f2)
        new_state=$(echo "$change_info" | cut -d'|' -f3)
        counter=$(get_change_counter)
        
        debug "No new change, but reporting previous change"
        echo "PUA_Policy=$CURRENT_STATE (Changed from $old_state to $new_state on $change_date count=$counter)"
    else
        # No change has ever been recorded
        debug "No change in state - reporting with last check date"
        echo "PUA_Policy=$CURRENT_STATE (unchanged since $(date -r "$PREVIOUS_STATE_FILE" '+%Y-%m-%d'))"
    fi
fi

if [ "$DEBUG" -eq 1 ]; then
    echo "=== MDATP Custom Attribute Script Completed ===" >&2
fi

exit 0