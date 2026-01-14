# Failed Authentication Notifier for Linux (Personal Project)

## Overview

This repository contains a **personal security-focused Linux project** that integrates with the Linux Pluggable Authentication Modules (PAM) framework to monitor failed authentication attempts. When a login attempt fails, the system captures an image using the machine’s default webcam, stores the image locally, and sends an automated email notification to a configured address.

The goal of this project is to explore Linux authentication internals, PAM configuration, and mail transfer agents in a real-world security context. This is **not an academic assignment** and was built independently as a hands-on learning and experimentation project.

---

## How It Works

1. **PAM Integration**
   The system hooks into PAM via the `common-auth` configuration file. On a failed authentication attempt, PAM executes a custom shell script.

2. **Failed Login Script Execution**
   The `failed_login_script.sh` script is triggered during authentication failure events. This script:

   * Captures an image using the system’s default webcam
   * Stores the image under:

     ```
     /home/<username>/Documents/FailedLoginAuth/
     ```
   * Composes and sends an email alert containing information about the failed attempt

3. **Email Notification**
   Email alerts are sent using Postfix as the Mail Transfer Agent (MTA), with authentication handled via SASL. By default, the configuration relays mail through Gmail’s SMTP server over port 587, though this can be adapted for other SMTP providers.

---

## Open-Source Tools and Technologies Used

This project relies entirely on widely used, open-source Linux tools and subsystems:

* **PAM (Pluggable Authentication Modules)**
  Provides the authentication framework that allows custom actions to be triggered during login attempts.

* **Bash**
  The core automation logic is implemented in a shell script (`failed_login_script.sh`), responsible for handling execution flow, webcam capture, and email triggering.

* **Postfix**
  Acts as the Mail Transfer Agent (MTA), responsible for sending outbound email notifications securely.

* **SASL (Simple Authentication and Security Layer)**
  Used by Postfix to authenticate with the external SMTP relay (e.g., Gmail).

* **mutt**
  A lightweight command-line mail client used to construct and send email messages from within the script.

* **fswebcam**
  A lightweight command-line webcam utility used to capture images from the system’s default webcam during failed authentication attempts. fswebcam interfaces with the webcam device directly and is well-suited for scripting and non-interactive use cases.

All tools used are standard on most Debian-based Linux distributions or are available via official package repositories.

---

## Configuration Files

The following files must be configured carefully for correct operation:

### `common-auth` (PAM)

* Located at: `/etc/pam.d/common-auth`
* Must be modified to include a hook that executes `failed_login_script.sh` on authentication failure
* Incorrect configuration may result in login lockouts

### `failed_login_script.sh`

* Must be executable (`chmod +x failed_login_script.sh`)
* Can be placed in any directory, as long as the PAM configuration references the correct path
* Should retain restrictive default permissions for security

### `main.cf` (Postfix)

* Located at: `/etc/postfix/main.cf`
* Configured to relay email through an external SMTP server
* The provided configuration is tailored for **Debian-based systems**; other distributions may require adjustments

### `sasl_passwd`

* Located in the Postfix directory (commonly `/etc/postfix/`)
* Stores SMTP credentials (email address and app-specific password)
* Format must match Postfix SASL requirements
* Credentials should be generated via the email provider (e.g., Gmail App Passwords)

If an alternative credentials file is used, its path must be updated under:

```
smtp_sasl_password_maps = hash:/path/to/file
```

---

## Important Warnings

⚠ **Proceed with caution.** This project directly modifies authentication behavior. Misconfiguration can cause:

* Temporary login failures
* Permanent account lockouts
* System access issues

Always test changes carefully and maintain a recovery method (e.g., live USB or root shell access).

---

## Known Limitations and Issues

* The script may trigger more than once per failed attempt
* Execution can occur on lock-screen failures, not just login screens
* Failed attempts during boot may not send emails if networking is unavailable
* Open or unfiltered SSH ports could be abused to generate email spam
* No rate limiting is implemented; every failed attempt generates an email

---

## Disclaimer

This project is intended for **educational and experimental purposes only**. It should not be deployed on production systems without additional safeguards such as rate limiting, logging controls, and hardened authentication policies.
