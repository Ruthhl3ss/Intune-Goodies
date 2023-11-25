#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# remove the previous line if you want to run the script line by line.
# in terminal type: bash -x scriptname

# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
# -------------------------------------------------------------------------------------------------------------------------------

# Credits where credit's due:
# original script can be found at: https://github.com/microsoft/shell-intune-samples/blob/master/macOS/Config/Dock/addAppstoDock.sh
# original script will also add apps to dock.This script will only add network shares to the dock

# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/
# Since I made many changes compared to the orifinal script, I think it's OK to put my name on this script.

# SCRIPT VERSION/HISTORY:
# 15-11-2023 - Oktay Sari - original script downsized to only deploy network shares without anything extra
# 16-11-2023 - Oktay Sari - script restored with original functions and checks. Only part that adds apps to the dock is removed. This script will only add network shares to the dock 
# 23-11-2023 - Oktay Sari - Add remove items in dock section "others" before continuing
# 24-11-2023 - Oktay Sari - Update other Dock settings like resize etc. 
# 25-11-2023 - Oktay Sari - Added Functions to handle Dock shortcut updates when shares change
# 25-11-2023 - Oktay Sari - Removed code to stop running script when checkfile exist. This is no longer neccessary because the script can now be scheduled to run with certain interval.
# 25-11-2023 - Oktay Sari - Removed Swift Dialog because I have no need for it
# 25-11-2023 - Oktay Sari - Better logging and error handling
# 25-11-2023 - Oktay Sari - More comments in script to explain workings

# ROADMAP/WISHLIST:
# 1: Update icons for (smb shares) shortcuts to custom icons. This one is a tough one. Feel free to help out. 

# Requirements:
# MDM to deploy script
# to access on-premise network shares, you will have to configure a VPN on your modern workplace.

# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
log="$HOME/addSMBSharesToDock.log"
appname="Dock"
startCompanyPortalifADE="false"
secondsToWaitForOtherApps=1800

# Initialize log file
if [[ ! -f "$log" ]]; then
    touch "$log"
fi
echo "------ Script Execution: $(date) ------" | tee -a "$log"

exec &> >(tee -a "$log")

# Function to check and update Dock items when there's a change.
# Extract URLs from the Dock's plist and ensures they are valid SMB URLs before processing them.
# Resets the index to 0 after each removal, considering the re-fetching of the Dock items.
# Skips items that don't match the expected smb:// URL pattern, preventing errors.

function updateDockItems() {
    local update_needed=false

    # Function to refresh current Dock items
    refreshDockItems() {
        IFS=$'\n' read -r -d '' -a current_items < <(defaults read com.apple.dock persistent-others | grep -o '"_CFURLString" = "[^"]*"' | sed 's/"_CFURLString" = "//' | sed 's/"$//' && printf '\0')
    }

    # Initial fetch of current Dock items
    refreshDockItems

    # Remove shares not in netshares
    local index=0
    while [ $index -lt ${#current_items[@]} ]; do
        local item="${current_items[$index]}"
        # Skip if item is not a valid URL
        if [[ ! "$item" =~ ^smb:// ]]; then
            ((index++))
            continue
        fi

        local found=false
        for share in "${netshares[@]}"; do
            if [[ "$item" == "$share" ]]; then
                found=true
                break
            fi
        done

        if [ "$found" = false ]; then
            echo "$(date) | Removing unmatched SMB share from Dock: $item"
            /usr/libexec/PlistBuddy -c "Delete :persistent-others:$index" ~/Library/Preferences/com.apple.dock.plist
            update_needed=true
            refreshDockItems  # Re-fetch current items after deletion
            index=0  # Reset index since list is re-fetched
        else
            ((index++))
        fi
    done

    # Add new SMB shares if they are not already in the Dock
    for share in "${netshares[@]}"; do
        local exact_match_found=false
        for item in "${current_items[@]}"; do
            if [[ "$item" == "$share" ]]; then
                exact_match_found=true
                break
            fi
        done

        if [ "$exact_match_found" = false ]; then
            update_needed=true
            label="$(basename "$share")"
            echo "$(date) | Adding [$share][$label] to Dock"
            defaults write com.apple.dock persistent-others -array-add "<dict><key>tile-data</key><dict><key>label</key><string>$label</string><key>url</key><dict><key>_CFURLString</key><string>$share</string><key>_CFURLStringType</key><integer>15</integer></dict></dict><key>tile-type</key><string>url-tile</string></dict>"
        fi
    done

    # Restart Dock if updates were made
    if [ "$update_needed" = true ]; then
        echo "$(date) | Restarting Dock"
        killall Dock || { echo "$(date) | Failed to restart Dock"; return 1; }
    else
        echo "$(date) | No updates required for Dock. Exiting."
        exit 0
    fi
}


# Define your network shares here
# You can add, remove or change existing shares and the script will do it's magic.
# NOTE: The script will remove shortcuts from the dock, that do not match the shares defined here! 
# NOTE: Keep this in mind because if you want to deploy multiple scripts with other shares, a conflict will occur!
netshares=("smb://192.168.0.12/Data" "smb://192.168.0.12/Tools" "smb://192.168.0.12/Home")


echo "# $(date) | ------------- Start configuration of $appname -------------"

# function to delay until the user has finished setup assistant.
# This function waits for the Dock process to be running, which is useful if the script is run at startup or during a user's initial login or enrollment to Intune. 
# If the script is intended to be run only when the system is already up and the user is logged in, this function might be unnecessary.
waitForDesktop () {
  until ps aux | grep /System/Library/CoreServices/Dock.app/Contents/MacOS/Dock | grep -v grep &>/dev/null; do
    delay=$(( $RANDOM % 50 + 10 ))
    echo "$(date) |  + Dock not running, waiting [$delay] seconds"
    sleep $delay
  done
  echo "$(date) | Dock is here, lets carry on"
}

waitForDesktop

# The START variable below and the subsequent waiting logic (checking if it's waited more than secondsToWaitForOtherApps) could be redundant 
# if you're sure that the script won't be running immediately after startup or if the system is already stable when the script runs.
# The original script uses this routine to wait for other apps to install.
# I'm leaving it here as a fail-safe

START=$(date +%s) # define loop start time so we can timeout gracefully
echo "$(date) | Have a break...have a coffee...we are getting things ready..."

  # If we've waited for too long, we should just carry on
  if [[ $(($(date +%s) - $START)) -ge $secondsToWaitForOtherApps ]]; then
      echo "$(date) | Waited for [$secondsToWaitForOtherApps] seconds, continuing anyway]"
  fi    

  echo "$(date) | ------------- Adding Network Shares to Dock -------------"

# NOTE: The script no longer waits for apps to be installed like the original script did. This means that the shares might be available, before your VPN profile lands on the device.
# If you want to wait for certain apps to be installed, use the original script and make changes to this script accordingly.
# I did test this, and during enrollment, my VPN client software and configuration did deploy quickly, so I wanted to keep this script as clean as possible.

# Add network shares to Dock
updateDockItems || { echo "$(date) | Error updating Dock items"; exit 1; }

# Configure other Dock settings. Comment out anything you don't need.

echo "$(date) | Enabling Magnification"
defaults write com.apple.dock magnification -boolean YES
defaults write com.apple.dock largesize -int 70

echo "$(date) | Enable Dim Hidden Apps in Dock"
defaults write com.apple.dock showhidden -bool true

echo "$(date) | Disable show recent items"
defaults write com.apple.dock show-recents -bool FALSE

echo "$(date) | Enable Minimise Icons into Dock Icons"
defaults write com.apple.dock minimize-to-application -bool yes


echo "$(date) |  ------------- successfully deployed shares to Dock -------------"

# If this is an ADE enrolled device (DEP) we should launch the Company Portal for the end user to complete registration
# If this script is not used in an Apple Device Enrollment (ADE) environment, or if you do not need to automate the launching of the Company Portal, this part of the script is unnecessary.
# If you do remove this part, don't forget to remove the variable startCompanyPortalifADE at the beginning of this script
if [ "$startCompanyPortalifADE" = true ]; then
  echo "$(date) | Checking MDM Profile Type"
  profiles status -type enrollment | grep "Enrolled via DEP: Yes"
  if [ ! $? == 0 ]; then
    echo "$(date) | This device is not ABM managed, exiting"
    exit 0;
  else
    echo "$(date) | ------------- Device is ABM Managed. launching Company Portal -------------"
    open "/Applications/Company Portal.app"
  fi
fi

