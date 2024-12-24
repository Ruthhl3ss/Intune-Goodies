#!/bin/sh
#set -x
# -------------------------------------------------------------------------------------------------------------------------------
# Custom Attribute Script to Check if the Apache HTTPD Service is Disabled
# CIS Benchmark Level 1 - 4.2 Ensure HTTP Server Is Disabled (Automated)
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
# SCRIPT VERSION/HISTORY:
# Original script: 
# 21-12-2024 - Oktay Sari - script version 1.0
#
# ROADMAP/WISHLIST:
#
#
# Requirements:
# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Check if Apache HTTPD service is running
httpd_status=$(/bin/launchctl list | /usr/bin/grep -c "org.apache.httpd")

# Determine service status
if [[ $httpd_status -eq 0 ]]; then
    echo "PASSED: The httpd service is disabled"
else
    echo "FAILED: The httpd service is running and needs to be disabled"
fi


