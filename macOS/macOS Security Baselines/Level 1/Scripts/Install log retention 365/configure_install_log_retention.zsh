#!/bin/zsh
# -------------------------------------------------------------------------------------------------------------------------------
# Script to configure /var/log/install.log retention and rotation settings for CIS compliance
# CIS Benchmark Level 1 - 3.3 Ensure install.log Is Retained for 365 or More Days and No Maximum Size
# -------------------------------------------------------------------------------------------------------------------------------
#
# remove the previous line (set -x) if you want to run the script line by line.
# in terminal type: bash -x scriptname
#
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
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
# 21-12-2024 - Oktay Sari - Script version 1.0 - Configures install.log settings for retention and rotation.
#
# ROADMAP/WISHLIST:
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
#!/bin/zsh
# -------------------------------------------------------------------------------------------------------------------------------
# Script to configure /var/log/install.log retention and rotation settings for CIS compliance
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
appname="InstallLogRetention"
logandmetadir="/Library/Logs/Microsoft/IntuneScripts/$appname"
log="$logandmetadir/$appname.log"
aslconfig="/etc/asl/com.apple.install"
backup="$aslconfig.bak"
ttlvalue="365"
rotationtype="utc"

# Check if the log directory has been created
if [ -d "$logandmetadir" ]; then
    echo "$(date) | Log directory already exists - $logandmetadir"
else
    echo "$(date) | Creating log directory - $logandmetadir"
    mkdir -p "$logandmetadir"
fi

# Start logging
exec &> >(tee -a "$log")

# Define the function to configure log retention and rotation
ConfigureLogRetention() {
    echo "$(date) | Checking if $aslconfig exists..."
    if [ ! -f "$aslconfig" ]; then
        echo "$(date) | Error: $aslconfig not found. Exiting."
        exit 1
    fi

    echo "$(date) | Creating backup of $aslconfig..."
    cp "$aslconfig" "$backup"
    echo "$(date) | Backup created at $backup."

    echo "$(date) | Configuring ttl value..."
    if grep -q "^\\s*.*ttl=.*" "$aslconfig"; then
        sed -i '' "s/^\\s*.*ttl=.*/ttl=$ttlvalue/" "$aslconfig"
        echo "$(date) | Updated ttl value to $ttlvalue days."
    else
        echo "ttl=$ttlvalue" >> "$aslconfig"
        echo "$(date) | Added ttl value with $ttlvalue days."
    fi

    echo "$(date) | Removing all_max setting if it exists..."
    if grep -q "^\\s*.*all_max=.*" "$aslconfig"; then
        sed -i '' "/^\\s*.*all_max=.*/d" "$aslconfig"
        echo "$(date) | Removed all_max setting."
    else
        echo "$(date) | No all_max setting found. Skipping."
    fi

    echo "$(date) | Configuring rotation type..."
    if grep -q "^\\s*.*rotate=.*" "$aslconfig"; then
        sed -i '' "s/^\\s*.*rotate=.*/rotate=$rotationtype/" "$aslconfig"
        echo "$(date) | Updated rotation type to $rotationtype."
    else
        echo "rotate=$rotationtype" >> "$aslconfig"
        echo "$(date) | Added rotation type with $rotationtype."
    fi

    echo "$(date) | Configuration of $aslconfig completed. Please validate changes manually."
}

# Begin Script Body
echo ""
echo " -----------------------------------------------------------"
echo " $(date) | Starting script $appname"
echo " -----------------------------------------------------------"
echo ""

# Run the function
ConfigureLogRetention