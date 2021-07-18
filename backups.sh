#!/bin/bash

# declare the variables
declare - arr=("backup1" "backup2" "backup3")

# header with date
echo -e "\n" >> /home/user/log
echo -e "-------- Daily backups --------\n" >> /home/user/log
echo -e "Failed backups on $(date +"%Y-%m-%d")\n" >> /home/user/log

# check if the backup is there for the current day; if not, log the last backup from the folder
for i in "${arr[@]}"; do
 cd /home/backups/$i/
 var=$(find . -type f -mtime -1)
 if [ -z "$var" ]; then
 var2=$(echo -e "$i -> \c" && echo -e "Last backup: \c" && ls -ltrh | tail -1 | awk '{ print $9 }')
 echo "$var2" >> /home/user/log
 fi
done

# omit the header; if the log contains an entry for a failed bakup, a mail will be send
var3=$(cat /home/user/log | sed -n '7,1000p')
if [ ! -z "$var3" ]; then
cat /home/user/log | sendmail mail_address@domain.com
fi

rm /home/user/log
