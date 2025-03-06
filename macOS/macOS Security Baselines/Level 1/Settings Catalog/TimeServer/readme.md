# CIS Benchmark Custom Implementation

## Profile name: macOS - Hardening - CIS_L1 - v1.0 - TimeServer

## Overview
**Configure Time Server**
This configuration sets a reliable time server for macOS devices to ensure accurate system time, which is essential for secure operations.


## Key Features
**Time Server Settings: Ensure Accurate and Consistent Timekeeping**  
Configuring the Time Server payload ensures that macOS devices maintain accurate system time, which is essential for secure communication, logging, and synchronization across networks. 
Using a reliable time server helps prevent issues caused by incorrect time settings.


## Configuration Values  

| Configuration Name | CIS Recommendation | Current Setting | Notes |
|-------------------|--------------------:|-----------------|-------|
| Time Zone | According to your needs | Not configured | |
| Time Server | According to your needs | time.apple.com | |

## Understanding the Table
The table above shows both the CIS (Center for Internet Security) recommended values and our current implementation. Where these values differ, we've made a risk-based decision to either increase security beyond CIS recommendations or to allow specific functionality based on organizational needs. **Review these settings carefully when implementing.**

## Benefits  
This configuration ensures that devices synchronize with Apple’s official time server, providing accurate and consistent timekeeping. 
Proper time synchronization is critical for authentication processes, audit logs, and overall system reliability.

## ⚠️  IMPACT
No known impact

**Deployment:**
1. Import the JSON configuration to Microsoft Intune
2. Review the application list and settings
3. Adjust as needed to match organizational requirements
4. Assign to appropriate device groups or users