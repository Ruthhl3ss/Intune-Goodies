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
