#!/bin/bash

#!/bin/zsh
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Script for/to ......
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
# 19-12-2024 - Oktay Sari - script version 1.0
#
# Original script: 
#
# ROADMAP/WISHLIST:
#
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Microsoft Intune Custom Attribute
rootCheck=$(dscl . read /Users/root | grep -q AuthenticationAuthority; echo $?)

if [ "$rootCheck" -eq 1 ]; then
    echo "PASSED: Root Disabled"
    exit 101  # Fixed exit code for "pass"
else
    echo "FAILED: Root is enabled"
    echo "$output"
    exit 102  # Fixed exit code for "fail"
fi