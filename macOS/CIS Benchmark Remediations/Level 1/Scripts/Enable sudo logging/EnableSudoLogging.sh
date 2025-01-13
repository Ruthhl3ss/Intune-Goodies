#!/bin/zsh
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script to enable logging for sudo commands on macOS
# CIS Level 1 - 5.11 Ensure Logging Is Enabled for Sudo
# -------------------------------------------------------------------------------------------------------------------------------
#
# remove the previous line (set -x) if you want to run the script line by line.
# in terminal type: bash -x scriptname
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
#
# IMPORTANT DISCLAIMER ABOUT SUDOERS FILE:
# The /etc/sudoers file is critical to system operation and controls administrative privileges on your macOS device. 
# **MISTAKES CAN LOCK YOU OUT OF YOUR SYSTEM.** If the sudoers file contains syntax errors, you may lose the ability to run commands 
# as an administrator, requiring recovery via single-user mode or external boot media. Always use `visudo` to edit the file safely, 
# as it checks for syntax errors before saving changes. This script creates a backup of the sudoers file in /root/sudoers.bak to aid 
# in recovery, but it is your responsibility to ensure the changes made are correct and tested in a controlled environment.
#
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
# Original: 
# 20-12-2024 - Oktay Sari - Added logging and clarity
# 20-12-2024 - Oktay Sari - Enable logging for sudo commands.
# 20-12-2024 - Oktay Sari - safe backup of sudoers
# 20-12-2024 - Oktay Sari - script version 1.0
#
# ROADMAP/WISHLIST:
#
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
#!/bin/zsh
# -------------------------------------------------------------------------------------------------------------------------------
# Script to enable logging for sudo commands on macOS
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
appname="EnableSudoLogging"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"
sudoers_backup="/root/sudoers.bak"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    echo "$(date) | Log directory already exists - $logandmetadir"
else
    echo "$(date) | Creating log directory - $logandmetadir"
    mkdir -p "$logandmetadir"
fi

# Start logging
exec &> >(tee -a "$log")

# Define the function to enable sudo logging
EnableSudoLogging() {
    echo "$(date) | Backing up the /etc/sudoers file to $sudoers_backup..."
    sudo cp /etc/sudoers "$sudoers_backup"
    if [ $? -ne 0 ]; then
        echo "$(date) | Error: Failed to create a backup of /etc/sudoers. Exiting."
        exit 1
    fi
    sudo chmod 600 "$sudoers_backup"
    echo "$(date) | Backup created successfully at $sudoers_backup."

    echo "$(date) | Checking for 'Defaults log_allowed' entry in /etc/sudoers..."
    if ! sudo grep -q "^Defaults log_allowed" /etc/sudoers; then
        echo "$(date) | 'Defaults log_allowed' not found. Adding entry to enable logging."
        echo "Defaults log_allowed" | sudo tee -a /etc/sudoers > /dev/null
        if [ $? -ne 0 ]; then
            echo "$(date) | Error: Failed to update /etc/sudoers. Restoring from backup."
            sudo cp "$sudoers_backup" /etc/sudoers
            exit 1
        fi
        echo "$(date) | Successfully added 'Defaults log_allowed' to enable logging."
    else
        echo "$(date) | 'Defaults log_allowed' entry already exists. No changes needed."
    fi

    echo "$(date) | Verifying the sudo logging configuration..."
    if sudo /usr/bin/sudo -V | /usr/bin/grep -q "Defaults log_allowed"; then
        echo "$(date) | Sudo logging is enabled successfully."
    else
        echo "$(date) | Error: Verification failed. Please review /etc/sudoers."
        exit 1
    fi
}

# Begin Script Body
echo ""
echo " -----------------------------------------------------------"
echo " $(date) | Starting script $appname"
echo " -----------------------------------------------------------"
echo ""

# Run the function
EnableSudoLogging