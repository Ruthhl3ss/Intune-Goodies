# CIS recommendation 2.7.1 Ensure Screen Saver Corners Are Secure

## **Description:**
Hot Corners on macOS allow users to assign specific functions to the corners of their screen. While this feature can enhance productivity, it poses a security risk when configured to **disable the screen saver**. By simply moving the cursor to a designated corner, an unauthorized individual could bypass the login screen and gain access to the system.

This repository provides a **configuration profile** to secure Hot Corners, ensuring they cannot be set to disable the screen saver. This is crucial in environments where device security is a priority, such as government, healthcare, education, and professional services.

---

## **Why This Is Important:**

1. **Prevents Unauthorized Access:**
   Disabling the screen saver via Hot Corners could allow an unauthorized user to access a machine without logging in.

2. **Enforces Compliance:**
   Ensuring Hot Corners are secure helps maintain compliance with security benchmarks like **CIS Level 2** standards.

3. **Standardizes Device Configuration:**
   Applying consistent settings across all managed macOS devices reduces the risk of human error and configuration drift.

---

## **How to Configure Using Microsoft Intune:**

### **Step 1: Download the Configuration Profile**
This repository includes a pre-configured `.mobileconfig` file: `secure_hot_corners.mobileconfig`.

### **Step 2: Upload the Profile to Intune**

1. Go to **Microsoft Endpoint Manager Admin Center**.
2. Navigate to **Devices > macOS > Configuration profiles**.
3. Click **+ Create profile**.
4. Select **Profile type**: `Custom`.
5. Upload the downloaded `.mobileconfig` file.

### **Step 3: Assign the Profile to Targeted Devices**

1. After uploading, assign the profile to the appropriate **device groups** or **user groups** within your organization.
2. Monitor the deployment to ensure all devices receive the profile.

---

## **Verifying the Configuration on macOS:**

1. On the target macOS device, go to **System Settings > Privacy & Security > Profiles**.
2. Look for the profile named **"Secure Hot Corners Profile - Intune Deployment"**.
3. Ensure the settings are applied correctly by checking the Hot Corners in **System Settings > Desktop & Dock**.

---

## **Technical Details of the Profile:**

The profile secures the following Hot Corners:

- **Top-Left Corner:** Starts Screen Saver
- **Top-Right Corner:** Starts Screen Saver
- **Bottom-Left Corner:** Mission Control
- **Bottom-Right Corner:** Application Windows

These settings prevent users from configuring any corner to disable the screen saver.

---

## **Contributing:**

If you have suggestions for improving this configuration or additional security profiles, feel free to submit a pull request or open an issue.

---

## **License:**

This project is licensed under the MIT License.
