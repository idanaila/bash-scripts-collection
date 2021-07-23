#!/bin/bash

function isroot()
{
root_uid=0
if [ "$UID" -eq "$root_uid" ]
then
echo -e "You are logged as root.\n"
else
echo -e "You are NOT logged as root. Please run the script as root. \n"
fi
}

function backup24()
{
#echo -e "Backup files that have been modified within the last 24h..."
backup=backup-$(date +%d-%m-%Y)
archive=${1:-$backup}
find /home/ -mtime -1 -type f -print0 | xargs -0 tar rfP "$backup.tar"
echo -e "Backup succesfully executed\n"
}

function backup()
{
#echo -e "Backup files from a given path..."
backup=backup-$(date +%d-%m-%Y)
archive=${1:-$backup}
read -p "Enter path: " path
find $path -mtime -1 -type f -print0 | xargs -0 tar rfP "$backup.tar"
echo -e "Backup of $path succesfully executed\n"
}

function countFF()
{
read -p "Enter path: " path
echo -e "Files / Folders : $(find $path "$@" -type f | wc -l) / $(find $path "$@" -type d | wc -l)\n"
}

function lastupdatedfile()
{
var=$(ls -ltrh | grep ^- | awk 'END{print $NF}')
var1=$(ls -ltrh | grep ^- | awk 'END{print $6, $7, $8}')
cd /home/
echo -e "The last updated file from /home is: $var on $var1\n"
}

function duplicateL()
{
read -p "Enter the file path: " path
if [ -f "$path" ]; then
sort $path | uniq > sorted.txt
echo "The file has been sorted successfully. You may find it in the same folder as the original file."
else
echo "No $path file...try again"
fi
}

function clearlog()
{
cd /var/log/
cat /dev/null | tee *
}

function mail()
{
read -p "Recipient: " recipient
read -p "Subject: " subject
read -p "Message: " message
mail -s $subject $recipient <<< $message
}

function newdir()
{
read -p "Enter the desired name: " direct
read -p "Enter the desired path: " path
if [ ! -f "$path" ] && [ -d "$direct" ]; then
echo "The path $path is incorrect or the directory already exists in $path...try again"
else
cd $path
mkdir $direct
echo "The folder $dir was successfully created under $path. "
fi
}

function permissions()
{
read -p "Enter the desired path: " path
find $path -type f -perm 0777 -exec rm -i {} +;
echo "The files were successfully deleted. "
}

function diskusage()
{
var=80
while read line; do
 filesystem=$(echo $line | awk '{print $1}')
 percent=$(echo $line | awk '{print $5}')
 use=${percent%?}
 if [ $use -gt $var ]; then
  echo "The available remaining space in $filesystem is low: $percent"
 fi
done < <(df -h --total | grep -vi filesystem)
}

function updatedb()
{
sudo updatedb
if [ $? == 0 ]; then
echo "The local database was updated successfully. "
else
echo "The local database was NOT updated successfully. "
fi
}

function memory()
{
free
}

function suptime()
{
uptime
}

function whol()
{
who
}

function memoryc()
{
ps -eo pid,user,%mem,%cpu,comm --sort=-%mem | head -n 11
}

function cpuinfo()
{
cat /proc/cpuinfo | sed -n 1,25p
}

function hostinfo()
{
hostnamectl
}

function updatesystem()
{
echo "System update in progress..."
sudo apt update -y > /dev/null 2>&1
sudo apt autoremove > /dev/null 2>&1
sudo apt clean -y > /dev/null 2>&1
sudo apt autoclean -y > /dev/null 2>&1
echo "System updated successfully. "
}

function poandconn()
{
netstat -anpt
}

function loginact()
{
last
}

function scanrootkits()
{
if [  -x "$(command -v chkrootkit)" ]; then
echo "The program is already installed. "
else
echo "Error: chkrootkit is not installed." >&2
read -p "Do you want to install / update chkrootkit? (y/n) " chkroot
if [ "$chkroot" == "y" ]; then
sudo apt install -y chkrootkit
echo "The program was successfully installed."
elif [ "$chkroot" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
fi
echo -e "\n"
read -p "Do you want to run chkrootkit now? (y/n) " yesorno
if [ "$yesorno" == "y" ]; then
sudo chkrootkit
elif [ "$yesorno" == "n" ]; then
echo "Abort "
else
echo "Please try again "
fi
}

function iftops()
{
if [  -x "$(command -v iftop)" ]; then
echo "The program is already installed. "
else
echo "Error: iftop is not installed." >&2
read -p "Do you want to install / update iftop? (y/n) " iftops
if [ "$iftops" == "y" ]; then
sudo apt install -y iftop
echo "The program was successfully installed."
elif [ "$iftops" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
fi
echo -e "\n"
read -p "Do you want to run iftop now? (y/n) " yesorno
if [ "$yesorno" == "y" ]; then
#interface=($(netstat -i | awk '{print $1}' | sed -n '3,$'p) exit )
interface=($(ifconfig -s | tail -n +2 | awk '{print $1}') exit)
select name in "${interface[@]}"; do
 echo "You have chosen $name"
 sudo iftop -i $name
 [[ $name == "exit" ]] && break
done
elif [ "$yesorno" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
}

function johntheripper()
{
if [  -x "$(command -v john)" ]; then
echo "The program is already installed. "
else
echo "Error: john is not installed." >&2
read -p "Do you want to install / update john? (y/n) " johns
if [ "$johns" == "y" ]; then
sudo apt install -y john
echo "The program was successfully installed."
elif [ "$johns" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
fi
echo -e "\n"
read -p "Do you want to run john now? (y/n) " yesorno
if [ "$yesorno" == "y" ]; then
sudo /usr/sbin/unshadow /etc/passwd /etc/shadow > /tmp/crack.password.db
john /tmp/crack.password.db
elif [ "$yesorno" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
}

function icufw()
{
if [  -x "$(command -v ufw)" ]; then
echo "The program is already installed. "
else
echo "Error: ufw is not installed." >&2
read -p "Do you want to install / update ufw? (y/n) " ufws
if [ "$ufws" == "y" ]; then
sudo apt install -y ufw
echo "The program was successfully installed."
elif [ "$ufws" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
fi
echo -e "\n"
read -p "Do you want to run ufw now? (y/n) " yesorno
if [ "$yesorno" == "y" ]; then
echo "The status of ufw: "
sudo ufw status verbose
elif [ "$yesorno" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
read -p "Allow ssh? (y/n) " yesorno1
if [ "$yesorno1" == "y" ]; then
sudo ufw allow ssh
echo "Ssh allowed. "
else
sudo ufw deny ssh
echo "Ssh not allowed. "
fi
echo -e "\n"
read -p "Allow https? (y/n) " yesorno2
if [ "$yesorno2" == "y" ]; then
sudo ufw allow https
echo "Https allowed. "
else
sudo ufw deny https
echo "Https not allowed. "
fi
echo -e "\n"
read -p "Allow ftp? (y/n) " yesorno3
if [ "$yesorno3" == "y" ]; then
sudo ufw allow ftp
echo "Ftp allowed. "
else
sudo ufw deny ftp
echo "Ftp not allowed. "
fi
echo -e "\n"
sudo ufw enable
echo "The rules are set now and the firewall is up and running. "
}

function confssh()
{
if [  -x "$(command -v ssh)" ]; then
echo "The program is already installed. "
else
echo "Error: ssh is not installed." >&2
read -p "Do you want to install / update ssh? (y/n) " sshs
if [ "$sshs" == "y" ]; then
sudo apt install -y openssh-server
echo "The program was successfully installed."
elif [ "$sshs" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
fi
echo -e "\n"
read -p "Check status of ssh? (y/n) " yesorno
if [ "$yesorno" == "y" ]; then
sudo systemctl status ssh
elif [ "$yesorno" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
echo -e "\n"
sudo ufw allow ssh
echo "Ssh allowed in ufw."
read -p "Restart ssh service? (y/n) " yesorno3
if [ "$yesorno3" == "y" ]; then
sudo systemctl stop ssh
sleep 3
sudo systemctl start ssh
echo "Service restarted. "
fi
echo -e "\n"
read -p "Check status of ssh? (y/n) " yesorno2
if [ "$yesorno2" == "y" ]; then
sudo systemctl status ssh
else 
echo "Abort "
fi
echo -e "\n"
read -p "Disable root access via ssh? (y/n) " yesorno4
if [ "$yesorno4" == "y" ]; then
echo "PermitRootLogin no" >> /etc/ssh/ssh_config
else 
echo "Abort "
fi
echo -e "\n"
read -p "Disable ssh from trusting a host bases on its IP address? (y/n) " yesorno5
if [ "$yesorno5" == "y" ]; then
echo "IgnoreRhosts yes" >> /etc/ssh/ssh_config
echo "HostbasedAuthentication no" >> /etc/ssh/ssh_config
else 
echo "Abort "
fi
echo -e "\n"
read -p "Deny a user from logging with an empty password? (y/n) " yesorno6
if [ "$yesorno6" == "y" ]; then
echo "PermitEmptyPasswords no" >> /etc/ssh/ssh_config
else 
echo "Abort "
fi
echo -e "\n"
read -p "Drop ssh connection after 5 failed attempts? (y/n) " yesorno7
if [ "$yesorno7" == "y" ]; then
echo "MaxAuthTries 5" >> /etc/ssh/ssh_config
else 
echo "Abort "
fi
echo -e "\n"
read -p "Logs out users after 10 minutes of inactivity? (y/n) " yesorno8
if [ "$yesorno8" == "y" ]; then
echo "ClientAliveInterval 600" >> /etc/ssh/ssh_config
else 
echo "Abort "
fi
echo -e "\n"
echo "The rulles were successfully added in /etc/ssh/ssh_config "
}

function deltelnet()
{
if [ ! -x "$(command -v telnet)" ]; then
echo "Error: telnet is not installed." >&2
else
echo "The program is installed. "
read -p "Do you want to uninstall it? (y/n) " tels
if [ "$tels" == "y" ]; then
sudo apt-get remove telnet
echo "The program was successfully removed."
elif [ "$tels" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
fi
}

function disusb()
{
read -p "Do you want to disable the USB external storages on the host? (y/n) " usbs
if [ "$usbs" == "y" ]; then
echo "blacklist usb_storage" >> /etc/modprobe.d/blacklist.conf
echo "modprobe -r usb_storage" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
echo "The USB was successfully disabled for the current host."
elif [ "$usbs" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
}

function netparam()
{
echo "The following features will be modified:

Disable IP Forwarding
Disable Send Packet Redirects
Disable ICMP Redirect Acceptance "
echo -e "\n"
read -p "Do you want to modify the features listed above? (y/n) " feat
if [ "$feat" == "y" ]; then
sudo sed -i 's/.*net.ipv4.ip_forward.*/net.ipv4.ip_forward=0/' /etc/sysctl.conf > /dev/null
sudo sed -i 's/.*net.ipv4.conf.all.send_redirects.*/net.ipv4.conf.all.send_redirects = 0/' /etc/sysctl.conf > /dev/null
sudo sed -i 's/.*net.ipv4.conf.all.accept_redirects.*/net.ipv4.conf.all.accept_redirects = 0/' /etc/sysctl.conf > /dev/null
echo "The changes were executed successfully. "
elif [ "$feat" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
}

function lockboot()
{
echo -e "\n"
read -p "Do you want to lock the /boot partition? (y/n) " lockb
if [ "$lockb" == "y" ]; then
echo "LABEL=/boot     /boot   ext2    defaults,ro     1 2" | sudo tee -a /etc/fstab > /dev/null
elif [ "$lockb" == "n" ]; then
echo "Abort "
return 1
else
echo "Please try again "
fi
}

function setpermfor()
{
echo -e "\n"
read -p "Do you want to change permissions for the listed services/files? (y/n) " sett
if [ "$sett" == "y" ]; then
chown root:root /etc/anacrontab
chmod og-rwx /etc/anacrontab
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
chmod 644 /etc/passwd
chown root:root /etc/passwd
chmod 644 /etc/group
chown root:root /etc/group
chmod 600 /etc/shadow
chown root:root /etc/shadow
chmod 600 /etc/gshadow
chown root:root /etc/gshadow
elif [ "$sett" == "n" ]; then
echo "Abort "
else
echo "Please try again "
fi
}

function menu()
{
while true; do
 clear
 echo -e "---------------------------------"
 echo -e "maintenance script by Ion Danaila"
 echo -e "---------------------------------\n"
 echo -e "\n"
 isroot
 echo "1) Backup menu "
 echo "2) Files & folders "
 echo "3) System checks "
 echo "4) Maintenance "
 echo "q) Quit "
 echo -e "\n"
 echo -e "Enter your selection: \c"
 read option
 echo -e "\n"
 case $option in
  1) echo "1) Backup files that have been modified within the last 24h"
     echo "2) Backup by a given path "
     echo -e "\n"
     echo -e "Enter your selection: \c"
     #echo -e "\n"
     while read option2; do
      case $option2 in
       "1") echo -e "\n"
            backup24;;
       "2") echo -e "\n"
            backup;;
      esac
      break
      echo -e "Enter return to continue \c"
      read input
     done;;
  2) echo "1) Count files and folders from a give path "
     echo "2) Last updated file from /home "
     echo "3) Removing duplicate lines from file "
     echo "4) Send mail "
     echo "5) Create a new folder "
     echo -e "\n"
     echo -e "Enter your selection: \c"
     #echo -e "\n"
     while read option3; do
      case $option3 in
       "1") echo -e "\n" 
            countFF;;
       "2") echo -e "\n" 
            lastupdatedfile ;;
       "3") echo -e "\n"
            duplicateL;;
       "4") echo -e "\n"
            mail;;
       "5") echo -e "\n"
            newdir;;
      esac
      break
      echo -e "Enter return to continue \c"
      read input
     done;;
  3) echo "1) Check file system usage "
     echo "2) Check CPU info "
     echo "3) Check hostname info "
     echo "4) Check memory "
     echo "5) System uptime "
     echo "6) Currently logged users "
     echo "7) Top memory consuming processes"
     echo "8) Check ports and connections "
     echo "9) Login activity "
     echo "10) Monitor your network traffic by interface "
     echo -e "\n"
     echo -e "Enter your selection: \c"
     while read option19; do
      case $option19 in
       "1") echo -e "\n"
            diskusage;;
       "2") echo -e "\n"
            cpuinfo;;
       "3") echo -e "\n"
            hostinfo;;
       "4") echo -e "\n"
            memory;;
       "5") echo -e "\n"
            suptime;;
       "6") echo -e "\n"
            whol;;
       "7") echo -e "\n"
            memoryc;;
       "8") echo -e "\n"
            poandconn;;
       "9") echo -e "\n"
            loginact;;
       "10") echo -e "\n"
             iftops;;
      esac
      break
      echo -e "Enter return to continue \c"
      read input
     done;;
  4) echo "1) Clear system logs "
     echo "2) Add a user "
     echo "3) Update the local database "
     echo "4) Delete files with 777 permissions from given path "
     echo "5) Update the system "
     echo "6) Scan for rootkits "
     echo "7) Test the passwords from /etc/passwd with john "
     echo "8) Install and configure uncomplicated firewall (UFW) "
     echo "9) Configure SSH securely "
     echo "10) Disable telnet "
     echo "11) Disable USB usage "
     echo "12) Securing the host network "
     echo "13) Lock the boot directory "
     echo "14) Set permissions to root for anacrontab, cron, crontab and passwd, group,shadow files "
     echo -e "\n"
     echo -e "Enter your selection: \c"
     #echo -e "\n"
     while read option11; do
      case $option11 in
       "1") echo -e "\n"
            clearlog;;
       "2") echo -e "\n"
            while true; do
 	    echo "1) Add a new user "
  	    echo "2) Add a user with a specific user ID " 
 	    echo "3) Add a user on a specific group ID "
 	    echo "4) Add a user with an account expiry date "
 	    echo "5) Add a user with a password expiry date "
            echo "6) Set x days for an account to be locked due inactivity "
 	    echo -e "\n"
 	    echo -e "Enter your selection: \c"
 	    read option13
 	    echo -e "\n"
 	    #while read $option13; do
 	    case $option13 in
  	     1) echo -e "\n"
		read -p "Enter the user name: " username
     		sudo adduser $username
     		echo "The username $username was successfully created";;
  	     2) echo -e "\n"
		read -p "Enter the user name: " username
     		read -p "Enter user ID: " userid
     		sudo adduser --uid $userid $username
     		echo "The username $username was successfully created";;
  	     3) echo -e "\n"
		read -p "Enter the user name: " username
     		read -p "Enter group ID: " groupid
     		sudo adduser --gid $groupid $username
     		echo "The username $username was successfully created";;
  	     4) echo -e "\n"
		read -p "Enter the user name: " username
     		read -p "Enter the expiry date ( yyyy-mm-dd ): " expirydate
     		sudo adduser $username
                sudo chage -E $expirydate $username
     		echo "The username $username was successfully created";;
  	     5) echo -e "\n"
		read -p "Enter the user name: " username
     	  	read -p "Enter the expiry date ( days e.g 45 ): " expirypass
     		sudo adduser $username
     		sudo chage -M $expirypass $username
     		echo "The username $username was successfully created";;
             6) echo -e "\n"
		read -p "Enter the user name: " username1
		if id $username1 >/dev/null 2>&1; then
		read -p "Enter the numbers of days: " nrdays
		sudo chage -I $nrdays $username1
		echo "The username $username1 will be locked after $nrdays days of inactivity"
		else
		echo "The username $username1 do not exists. "
		fi;;
 	    esac
 	    break
            echo -e "Enter return to continue \c"
 	    read input
           done;;
       "3") echo -e "\n"
            updatedb;;
       "4") echo -e "\n"
            permissions;;
       "5") echo -e "\n"
            updatesystem;;
       "6") echo -e "\n"
            scanrootkits;;
       "7") echo -e "\n"
            johntheripper;;
       "8") echo -e "\n"
            icufw;;
       "9") echo -e "\n"
            confssh;;
       "10") echo -e "\n"
             deltelnet;;
       "11") echo -e "\n"
             disusb;;
       "12") echo -e "\n"
             netparam;;
       "13") echo -e "\n"
             lockboot;;
       "14") echo -e "\n"
             setpermfor;;
         #  done
      esac
      break
      echo -e "Enter return to continue \c"
      read input
     done;;

  q) exit;;
 esac
 echo -e "\n"
 echo -e "Enter return to continue \c"
 read input
done
}

menu



