FAILED AUTHENTICATION NOTIFIER FOR LINUX

This is a simple project that allows linux users that use PAM to configure authentications/logins to log failed authentication attempts by taking a picture through the system's default specified webcam and saving it into a directory in home/[username]/Documents/FailedLoginAuth.

This script automates emails to be sent out to a specified email using postfix and mutt. [This program is configured to send out emails using gmail's SMTP server over port 587 but it can be edited to relay emails to other SMTP servers] [The sasl_passwd file will have the email address and the cached password]
 
the common-auth file in etc/pam.d would have to be configured to look like the common-auth file as specified in the project files.

The bash script (failed_login_script.sh) attached to this project can be placed in the directory specified in common-auth or changed depending on preference. This script would also need to be an executable and preferrable to maintain the file with default permissions (chmod would be able to accomplish this). 

the main.cf file in etc/postfix would also have to be configured as specified in the main.cf file specified in the project files.

Create another file to contain the email address and it's associating app password, the format should be the same as sasl_passwd and the file's directory should be specified under the "smtp_sasl_password_maps = hash:/"  section of the main.cf 

The program should be able to run as intended if setup right, incorrect setup anything as intended may cause temporary or sometimes even permanent lock outs so proceed with caution.

Known Bugs:
- There may be times where the code will execute more than once and not when it's on a login screen
- If there is a failed attempt on bootup, it would not be able to push out an email if the computer isn't configured to connect to the internet on startup and hence the script will fail
