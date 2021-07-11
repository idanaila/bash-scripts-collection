#!/bin/bash

while true; do
 clear
 echo "------------Menu------------"
 echo -e "\n"
 echo "1) Option1 "
 echo "2) Option2  "
 echo "3) Option3 "
 echo "4) Option4 "
 echo "q) Quit "
 echo -e "\n"
 echo -e "Enter your selection: \c"
 read SELECT
 case $SELECT in
  1) echo "1) Option1.1"
     echo "2) Option1.2"
     while read SELECT2; do
      case $SELECT2 in
       "1") command1.1
       "2") command1.2
      esac
      break
      echo -e "Enter return to continue \c"
      read input
     done;;
  2) echo "1) Option2.1"
     echo "2) Option2.2"
     while read SELECT3; do
      case $SELECT3 in
       "1") command2.1
       "2") command2.2
      esac
      break
      echo -e "Enter return to continue \c"
      read input
     done;;
  3) command3.1
  4) command4.1
  q) exit;;
 esac
 echo -e "\n"
 echo -e "Enter return to continue \c"
 read input
done 
