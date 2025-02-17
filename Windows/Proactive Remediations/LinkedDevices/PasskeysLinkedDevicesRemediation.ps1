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
# FIDO LinkedDevices Remediation Script
# Removes entries under LinkedDevices while preserving the key structure

$ErrorActionPreference = "SilentlyContinue"
$VerbosePreference = "Continue"

# Base path that's consistent
$basePath = "Registry::HKEY_USERS\S-1-5-20\Software\Microsoft\Cryptography\FIDO"

try {
    # Get all subkeys under the FIDO path
    $fidoKeys = Get-ChildItem -Path $basePath -ErrorAction Stop
    $remediationNeeded = $false
    
    foreach ($key in $fidoKeys) {
        # Check for LinkedDevices under each FIDO key
        $linkedDevicesPath = Join-Path $key.PSPath "LinkedDevices"
        
        if (Test-Path $linkedDevicesPath) {
            Write-Verbose "Found LinkedDevices key at: $linkedDevicesPath"
            
            # Remove only the device entries under LinkedDevices
            $devices = Get-ChildItem -Path $linkedDevicesPath -ErrorAction SilentlyContinue
            if ($devices) {
                foreach ($device in $devices) {
                    Write-Verbose "Removing device: $($device.PSPath)"
                    Remove-Item -Path $device.PSPath -Recurse -Force
                }
                $remediationNeeded = $true
            } else {
                Write-Verbose "No devices found under LinkedDevices"
            }
        }
    }
    
    if ($remediationNeeded) {
        Write-Verbose "Remediation completed successfully"
        exit 0
    } else {
        Write-Verbose "No devices found to remove"
        exit 0
    }
    
} catch {
    Write-Verbose "Error during remediation: $_"
    exit 1
}