#!/bin/bash

function logo(){

cat << 'EOF'
  ____   _____    _____ _               _        
 / __ \ / ____|  / ____| |             | |       
| |  | | (___   | |    | |__   ___  ___| | _____ 
| |  | |\___ \  | |    | '_ \ / _ \/ __| |/ / __|
| |__| |____) | | |____| | | |  __/ (__|   <\__ \
 \____/|_____/   \_____|_| |_|\___|\___|_|\_\___/
                                                       
EOF

}

function logoo(){

cat << 'EOF'
  _______                   _____ 
 |__   __|                 / ____|
    | | ___ _ __ ___  _ __| (___  
    | |/ _ \ '_ ` _ \| '_ \\___ \ 
    | |  __/ | | | | | |_) |___) |
    |_|\___|_| |_| |_| .__/_____/ 
                     | |          
                     |_|          


EOF

}
		    
function checks(){

echo "Hostname: $(hostname)"
echo "CPU: $(cat /proc/cpuinfo | grep "model name" | awk '{print $6,$7,$9}' | sed -n '1p') x $(cat /proc/cpuinfo | grep "model name" | wc -l)"
echo "OS: $(cat /etc/os-release | grep ID= | sed -n 1p | cut -d "=" -f2 | tr '"' ' ')"
#echo "OS: $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d "=" -f2 | tr '"' ' ')"
echo "Memory: $(free -mh | sed -n 2p | awk '{print $3}') / $(free -mh | sed -n 2p | awk '{print $2}')"
echo "Uptime: $(uptime | awk '{print $3}' | cut -d "," -f1)"
echo "CPU load: $(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))"
}
echo
paste <(logo) <(checks)
echo

function temps(){

declare -a arr=($(lsblk -nd --output NAME | grep "sd*"))
for i in ${arr[@]}; do
 var=$(smartctl -a /dev/$i | grep "Temperature_Celsius" | awk '{print $10}')
 var1=$(smartctl -a /dev/$i | grep "Device Model" | awk '{print $3 $4}')
 echo "$var1: $var C"
done
sensors | grep "Core*" | awk '{print $1, $2, $3}'
echo -e "\n"
}
echo
paste <(logoo) <(temps)
echo
