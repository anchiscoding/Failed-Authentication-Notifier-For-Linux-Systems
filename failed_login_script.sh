#!/bin/bash

EMAIL= "[Your email would go here]"
SUBJECT="Security Alert: Attempted Breach Recorded On [Computer's Name]"

    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    PHOTO_PATH="/home/[Username]/Documents/PhotosDuringFailedLogin/FailedLoginAuth_$TIMESTAMP.jpg"

    fswebcam -r 640x480 --jpeg 100 -D 1 $PHOTO_PATH

 echo "SECURITY" | mutt -s "$SUBJECT" -a $PHOTO_PATH --  $EMAIL

