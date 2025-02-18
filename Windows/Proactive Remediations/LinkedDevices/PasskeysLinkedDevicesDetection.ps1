# -------------------------------------------------------------------------------------------------------------------------------
# DISCLAIMER: 
# This script is provided "as is" without warranties or guarantees of any kind. While it has been created to fulfill specific functions 
# and has worked effectively for my personal requirements, its performance may vary in different environments or use-cases. 
# Users are advised to employ this script at their own discretion and risk. 
# No responsibility will be assumed for any direct, indirect, incidental, or consequential damages that may arise from its use.
# ALWAYS TEST it in a controlled environment before deploying it in your production environment!
# -------------------------------------------------------------------------------------------------------------------------------

# AUTHOR: Oktay Sari
# https://allthingscloud.blog 
# https://github.com/oktay-sari/

# SCRIPT VERSION/HISTORY:
# 17-02-2025 - Oktay Sari - original script 

# MDM to deploy script
# -------------------------------------------------------------------------------------------------------------------------------
# Define variables# Passkey LinkedDevices Detection Script
# Returns 0 if LinkedDevices found (needs remediation)
# Returns 1 if no LinkedDevices found (compliant)
$ErrorActionPreference = "SilentlyContinue"
$VerbosePreference = "Continue"

# Base path that's consistent
$basePath = "Registry::HKEY_USERS\S-1-5-20\Software\Microsoft\Cryptography\FIDO"

try {
    # Get all subkeys under base path
    $fidoKeys = Get-ChildItem -Path $basePath -ErrorAction Stop
    
    foreach ($key in $fidoKeys) {
        # Check for LinkedDevices key under each subkey
        $linkedDevicesPath = Join-Path $key.PSPath "LinkedDevices"
        
        if (Test-Path $linkedDevicesPath) {
            $LinkedDeviceKeys = Get-ChildItem -Path $linkedDevicesPath -ErrorAction SilentlyContinue
            
            if ($LinkedDeviceKeys) {
                Write-Verbose "Found LinkedDevices with entries under $($key.PSPath)"
                # Exit with 0 to trigger remediation
                exit 0
            }
            Write-Verbose "Found empty LinkedDevices key under $($key.PSPath)"
        }
    }
    
    Write-Verbose "No LinkedDevices keys found with entries"
    # Exit with 1 if no LinkedDevices found
    exit 1
    
} catch {
    Write-Verbose "Error accessing registry: $_"
    # Exit with 1 if we can't access the registry
    exit 1
}
