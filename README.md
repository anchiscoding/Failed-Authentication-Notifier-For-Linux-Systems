# 🔐 Failed Authentication Notifier for Linux

![Platform](https://img.shields.io/badge/platform-Linux-blue)
![Status](https://img.shields.io/badge/status-Active-green)

A lightweight PAM-based utility for Linux systems that captures failed authentication attempts by:

- 📸 Taking a webcam snapshot
- 🗂️ Saving the image to `~/Documents/FailedLoginAuth/`
- 📧 Sending an email notification with the image attached

> **Warning**: Improper configuration may cause system lockouts. Test cautiously, ideally in a virtual machine first.

---

## 🚀 Features

- 📷 Captures image via system webcam after failed login
- 📤 Sends automated email alert via Gmail SMTP
- 💾 Saves attempt logs with images locally
- 🔧 Configurable for other SMTP servers

---

## 📂 Directory Structure

```bash
Failed-Authentication-Notifier-For-Linux-Systems/
├── failed_login_script.sh        # Core script triggered on failed auth
├── etc/
│   └── pam.d/
│       └── common-auth           # PAM config replacement
├── etc/
│   └── postfix/
│       └── main.cf               # Postfix config for Gmail SMTP
├── sasl_passwd                   # Email credentials (not committed)
└── README.md                     # This file
