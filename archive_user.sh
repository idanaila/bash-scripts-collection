#!/bin/bash

Help()
{

echo
echo -e "It locks an user account and archives his home directory"
echo -e "Usage: ./archive_user.sh -n user_account"
echo -e "-h; --help   display help"
echo -e "-n   specify user account\n"

}

Script()
{
echo

if [ "$EUID" -ne 0 ]; then 
 echo -e "ERROR - Please run as root\n"
 exit
fi


if id "$2" >/dev/null 2>&1; then
:
else
echo -e "ERROR - User does not exist\n"
exit
fi

# lock the account
if [ -z $(passwd -l "$2" 2>/dev/null 1>&2) ]; then
echo "$2 was locked"
else
echo "ERROR while locking the account"
fi

# create an archive of the home directory
tar cf $HOME/${2}.tar.gz -C / home/${2} 2>&1
echo "Archive saved under $HOME"

# count the files from /home user dir
VAR=$(tar tf $HOME/${2}.tar.gz | wc -l)
echo -e "Files archived: $VAR\n"

}

# script options
while getopts ":h:n" option; do
 case $option in
  h|--help) 
   Help
   exit;;
  n|--name) 
   Script "$@"
   exit;;
  *) 
   Help
   exit;;
 esac
done

