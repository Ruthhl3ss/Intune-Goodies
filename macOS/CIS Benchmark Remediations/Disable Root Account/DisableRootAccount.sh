#!/bin/zsh
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script to disable root user fully and ensure compliance with logging
# -------------------------------------------------------------------------------------------------------------------------------
#
# remove the previous line (set -x) if you want to run the script line by line.
# in terminal type: bash -x scriptname
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
#
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/
#
# NOTE:
# This script is by no means perfect. I'm also not an expert bash programmer. 
# If you think you have a good idea to further enhance this script, then please reach out.
#
# SCRIPT VERSION/HISTORY:
# Original script: https://nverselab.com/2022/06/13/automatically-locking-down-root-access-on-macos/
# 19-12-2024 - Oktay Sari - Added logging and clarity
# 19-12-2024 - Oktay Sari - Avoid temporary enabling root account using password.
# 19-12-2024 - Oktay Sari - script version 1.0
#
# ROADMAP/WISHLIST:
#
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
#!/bin/zsh
# -------------------------------------------------------------------------------------------------------------------------------
# Script to disable root user fully and ensure compliance with logging
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
appname="DisableRootUser"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    echo "$(date) | Log directory already exists - $logandmetadir"
else
    echo "$(date) | Creating log directory - $logandmetadir"
    mkdir -p "$logandmetadir"
fi

# Start logging
exec &> >(tee -a "$log")

# Define the function to disable the root user
DisableRootUser() {
    echo "$(date) | Checking if root user is enabled..."
    rootCheck=$(dscl . read /Users/root | grep AuthenticationAuthority 2>&1 > /dev/null; echo $?)

    if [ "$rootCheck" -eq 1 ]; then
        echo "$(date) | Root user is already disabled."
        exit 0
    else
        echo "$(date) | Root user is enabled. Proceeding with disablement..."

        # Remove the AuthenticationAuthority from the root user
        echo "$(date) | Removing AuthenticationAuthority..."
        dscl . delete /Users/root AuthenticationAuthority 2>/dev/null

        # Disable root login by setting the shell to /usr/bin/false
        echo "$(date) | Disabling root user shell..."
        dscl . -create /Users/root UserShell /usr/bin/false

        # Validate changes
        echo "$(date) | Validating disablement..."
        rootCheckPost=$(dscl . read /Users/root | grep AuthenticationAuthority 2>&1 > /dev/null; echo $?)
        if [ "$rootCheckPost" -eq 1 ]; then
            echo "$(date) | Root account successfully disabled."
            exit 0
        else
            echo "$(date) | Failure: Root account is still enabled. Manual intervention required."
            exit 1
        fi
    fi
}

# Begin Script Body
echo ""
echo " -----------------------------------------------------------"
echo " $(date) | Starting script $appname"
echo " -----------------------------------------------------------"
echo ""

# Run the function
DisableRootUser
