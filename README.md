# Scripts Collection

Scripts written along time doing various stuff

### OS details and temperatures check
Dependencies: smartmontools and lm-sensors
```
$ sudo ./checks.sh


  ____   _____    _____ _               _               Hostname: 99ee883394b9
 / __ \ / ____|  / ____| |             | |              CPU: i5-5200U CPU 2.20GHz x 4
| |  | | (___   | |    | |__   ___  ___| | _____        OS: ubuntu
| |  | |\___ \  | |    | '_ \ / _ \/ __| |/ / __|       Memory: 1.7Gi / 15Gi
| |__| |____) | | |____| | | |  __/ (__|   <\__ \       Uptime: 2:35
 \____/|_____/   \_____|_| |_|\___|\___|_|\_\___/       CPU load: 4.6875%



  _______                   _____       KINGSTONSA400S37480G: 35 C
 |__   __|                 / ____|      KINGSTONSA400S37240G: 32 C
    | | ___ _ __ ___  _ __| (___        ST1000LM024HN-M101MBB: 39 C
    | |/ _ \ '_ ` _ \| '_ \\___ \       Core 0: +47.0
    | |  __/ | | | | | |_) |___) |      Core 1: +46.0
    |_|\___|_| |_| |_| .__/_____/ 
                     | |          
                     |_|   

```
### Admin Bash Script
The program is a huge menu which executes various commands.
It can be install on any debian based OS and must be executed as root.
Based on your option, the program can ask you to install some packages e.g. iftop(required to monitor your network traffic by interface).
```
Install and execute
$ sudo dpkg -i abs_0.1-1_all.deb

$ sudo abs

You are logged as root. 

1) Backup menu 
2) Files & folders 
3) System checks 
4) Maintenance
5) Quit 


Enter your selection: 3


1) Check file system usage 
2) Check CPU info 
3) Check hostname info 
4) Check memory 
5) System uptime 
6) Currently logged users 
7) Top memory consuming processes
8) Check ports and connections 
9) Login activity 
10) Monitor your network traffic by interface 
```
