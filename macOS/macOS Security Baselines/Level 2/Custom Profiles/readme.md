# CIS Level 2 Configuration (Work in Progress)

Welcome to our **CIS Level 2 Configuration** repository! 🎉
This project is still a **work in progress**, so things might look a little incomplete or messy for now. But don't worry, I'm working hard to get everything polished and ready for prime time!

## Why Level 2?
Level 2 configurations are designed for environments where security is critical. Think:

- **Healthcare** 🏥
- **Government** 🏛️
- **Finance** 💰
- ...or anyone who's serious about locking things down 🔒.

## What's Next?
We're adding, tweaking, and testing configurations to make sure they align with best practices and are as user-friendly as possible. Here's what we're focusing on:

- 📚 Clear, detailed documentation
- ✅ Verified compatibility
- 🛠️ Easy-to-follow setup instructions

## macOS Security Baselines

**export/import notes** 

Most of the confuration items and profiles here are exported using the wonderfull tool **Intunemanagement** ( https://github.com/Micke-K/IntuneManagement/tree/master ) 
I've tried to create order in the chaos by structuring all files in it's own folder. Some folders will have 2 or more files. 

When you want no hassle, import the json files. This will import the policy itself, the policy name and descriptions I used. Feel **free to edit any file you import.**
Most of the policy names will have the following format: 

**Name:** macOS - Hardening - CIS_L1 - Disable AirDrop and Handoff

**Description:** CIS Benchmark Level 1 - 2.3.1 AirDrop & Handoff
- Disable Airdrop
- Diable Airplay
- Disable Handoff

-----------------------------------------------------------

**Settings Catalog**
- readme.md            : explains what's what.
- config.json file     : export with Intunemanagement

**What to import?** Only the .json files

-----------------------------------------------------------

**Scripts**
- readme.md            : explains what's what.
- script.sh            : the actual script I used
- config.json file     : export with Intunemanagement

**What to import?** Only the .json files if you can live with the naming convention I used. Otherwise, create a script in Intune and use the file provided.

-----------------------------------------------------------

**Custom Profiles**
- readme.md            : explains what's what.
- configuration.mobileconfig     : the .mobileconfig file
- configuration.plist            : the .plist file
- config.json file               : export with Intunemanagement

**What to import?** Only the .json files if you can live with the naming convention I used. 
Otherwise, create a **configuration profile** in Intune using a **template**, and then choose for:
- **Custom**          : when using a **.mobileconfig** file
- **Preference file** : when using a **.plist** file.

-----------------------------------------------------------

Cheers,  
Oktay
