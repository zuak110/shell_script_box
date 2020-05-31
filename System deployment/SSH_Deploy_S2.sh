#!/bin/bash
BASH_VERSION="v 0.0.1"

SYSTEM_TEMP='unknow'
RED_COLOR='\033[1;31m'  
YELOW_COLOR='\033[1;33m' 
BLUE_COLOR='\033[1;34m'
GREEN_COLOR='\033[1;32m'  
RESET='\033[0m'

printf "%s\n" " "
echo "======== Linux environment deployment one-key shell SSH_Step_2 ${BASH_VERSION} ========"

Get_Dist_Name()
{
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    #echo $DISTRO;
}

Check_Command_Exist()
{
    command -v $1 >/dev/null 2>&1 || { echo -e >&2 "${RED_COLOR} [ERROR] Require ${1} but it's not installed. ${RESET}"; return 1; }
}

printf "%s\n" " "

Get_Dist_Name
SYSTEM_TEMP=$DISTRO

echo -e "${YELOW_COLOR} Your System is : ${SYSTEM_TEMP}  \n Press Enter to Start ...... ${RESET}\c"
read temp


if [ ${PM} = "yum" ]; then
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
	echo -e "${YELOW_COLOR} Prepare to edit sshd_config ...  ${RESET}"
	sudo sed -i -e 's|PasswordAuthentication yes|PasswordAuthentication no|' /etc/ssh/sshd_config
	echo -e "${YELOW_COLOR} Prepare to restart sshd service ...  ${RESET}"
	service sshd restart
else
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
	echo -e "${YELOW_COLOR} Prepare to edit sshd_config ...  ${RESET}"
	sudo sed -i -e 's|PasswordAuthentication yes|PasswordAuthentication no|' /etc/ssh/sshd_config
	echo -e "${YELOW_COLOR} Prepare to restart sshd service ...  ${RESET}"
	sudo /etc/init.d/ssh stop
	sudo /etc/init.d/ssh start
fi   


cd ${BASEPATH}
sudo wget https://raw.githubusercontent.com/zuak110/shell_script_box/dev/banner > /dev/null 2>&1
sudo cat banner
sudo rm -f banner
printf "%s\n" " "
echo -e "${GREEN_COLOR} [DONE] Congratulations!  ${RESET}"
