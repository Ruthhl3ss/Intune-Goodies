# iOS App URL Protocol Extractor

This repository contains a bash script designed to extract and identify **URL protocols (CFBundleURLSchemes)** from the `Info.plist` file of an iOS app `.ipa` file. 

The script outputs:
1. **A complete list** of all `CFBundleURLSchemes` found in the app's `Info.plist`.
2. **The most likely URL protocols**, based on relaxed filtering rules to capture valid protocols like `exampleapp` or `exampleapp.beta`.

## How It Works

The script automates the following steps:
1. **Unzips the `.ipa` file**: Extracts its contents into a temporary directory.
2. **Locates the `Info.plist`**: Finds the metadata file inside the app bundle.
3. **Extracts all `CFBundleURLSchemes`**: Retrieves the raw list of URL schemes from the `Info.plist` using `xmllint` and XPath queries.
4. **Filters the Most Likely URL Protocols**:
   - Includes entries like `exampleapp` or `exampleapp.beta`.
   - Excludes internal identifiers like `com.company.app.internal` or overly complex entries.
5. **Outputs Results**:
   - Displays the full list of URL schemes.
   - Highlights the most likely URL protocols for ease of use.

The script ensures that even when no likely URL protocols are identified, the user is advised to manually review the full list for potential candidates.

---

## Example Usage
./extract-url-protocol.sh <path_to_ipa>

### Input:
An `.ipa` file containing the following `CFBundleURLSchemes` in its `Info.plist`:
