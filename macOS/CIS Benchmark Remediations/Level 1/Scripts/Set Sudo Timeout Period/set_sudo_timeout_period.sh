#!/bin/bash
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script to Esnsure the Sudo Timeout Period Is Set to Zero
# CIS Benchmark Level 1 - 5.4 Ensure the Sudo Timeout Period Is Set to Zero
# -------------------------------------------------------------------------------------------------------------------------------
#
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# -------------------------------------------------------------------------------------------------------------------------------
#
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
#
# -------------------------------------------------------------------------------------------------------------------------------
# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/
#
# NOTE:
# This script is by no means perfect. I'm not an expert bash programmer. 
# If you think you have a good idea to further enhance this script, then please reach out.
#
# SCRIPT VERSION/HISTORY:
# 07-01-2025 - Oktay Sari - Script version 1.0
#
# ROADMAP/WISHLIST:
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables
# Ensure the sudo timeout is set to 0
SUDOERS_DIR="/etc/sudoers.d"
SUDOERS_FILE="${SUDOERS_DIR}/01_sudoconfig"
EXPECTED_TIMEOUT="0"
EXPECTED_OWNER="root"
EXPECTED_GROUP="wheel"

# Function to ensure the sudoers.d directory ownership is correct
set_directory_permissions() {
    chown -R ${EXPECTED_OWNER}:${EXPECTED_GROUP} ${SUDOERS_DIR}
    chmod 750 ${SUDOERS_DIR}
}

# Check and create the sudoers.d directory if missing
if [ ! -d "${SUDOERS_DIR}" ]; then
    mkdir -p "${SUDOERS_DIR}"
    set_directory_permissions
fi
# NOTE
# The check for /etc/sudoers.d ensures the script can handle edge cases and makes it robust and portable. 
# While it might not be strictly necessary for a typical macOS system, it prevents failures in less common scenarios or environments where the folder is missing. 
# If you are optimizing for simplicity and are confident the folder will always exist, you can safely remove this check.

# Ensure the sudoers.d directory permissions
set_directory_permissions

# Check and set the timeout configuration
if ! grep -q "Defaults timestamp_timeout=${EXPECTED_TIMEOUT}" "${SUDOERS_FILE}" 2>/dev/null; then
    echo "Defaults timestamp_timeout=${EXPECTED_TIMEOUT}" > "${SUDOERS_FILE}"
    chmod 440 "${SUDOERS_FILE}"
fi

# Verify ownership and group of sudoers file
chown ${EXPECTED_OWNER}:${EXPECTED_GROUP} "${SUDOERS_FILE}"

# Output result
echo "Sudo timeout configuration applied successfully."
exit 0
