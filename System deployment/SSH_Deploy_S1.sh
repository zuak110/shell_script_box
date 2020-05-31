#!/bin/bash
BASH_VERSION="v 0.0.1"

SYSTEM_TEMP='unknow'
RED_COLOR='\033[1;31m'  
YELOW_COLOR='\033[1;33m' 
BLUE_COLOR='\033[1;34m'
GREEN_COLOR='\033[1;32m'  
RESET='\033[0m'

BASEPATH=$(cd `dirname $0`; pwd)

printf "%s\n" " "
echo "======== Linux environment deployment one-key shell SSH_Step_1 ${BASH_VERSION} ========"

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
	sudo ${PM} install wget -y
	sudo ${PM} install openssh* -y
	sudo systemctl enable sshd
	service sshd start
	
    if [ ! -d "~/.ssh" ]; then
		mkdir ~/.ssh
	fi
	cd ~/.ssh
	echo -e "${YELOW_COLOR} Prepare to get Public Key ...  ${RESET}"
	sudo wget https://raw.githubusercontent.com/zuak110/shell_script_box/dev/servers_rsa.pub > /dev/null 2>&1
	cat servers_rsa.pub >> authorized_keys
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
	chmod 600 authorized_keys
	chmod 700 ~/.ssh
	echo -e "${YELOW_COLOR} Prepare to edit sshd_config ...  ${RESET}"
	sudo sed -i -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|' /etc/ssh/sshd_config
	sudo sed -i -e 's|#PermitRootLogin yes|PermitRootLogin yes|' /etc/ssh/sshd_config
	sudo sed -i '/PubkeyAuthentication yes/a\RSAAuthentication yes' /etc/ssh/sshd_config
	echo -e "${YELOW_COLOR} Prepare to restart sshd service ...  ${RESET}"
	service sshd restart
else
	sudo ${PM} install wget -y
	sudo ${PM} install openssh-server -y
	sudo /etc/init.d/ssh start
	if [ ! -d "~/.ssh" ]; then
		mkdir ~/.ssh
	fi
	cd ~/.ssh
	echo -e "${YELOW_COLOR} Prepare to get Public Key ...  ${RESET}"
	sudo wget https://raw.githubusercontent.com/zuak110/shell_script_box/dev/servers_rsa.pub > /dev/null 2>&1
	cat servers_rsa.pub >> authorized_keys
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
	chmod 600 authorized_keys
	chmod 700 ~/.ssh
	echo -e "${YELOW_COLOR} Prepare to edit sshd_config ...  ${RESET}"
	sudo sed -i -e 's|#PubkeyAuthentication yes|PubkeyAuthentication yes|' /etc/ssh/sshd_config
	sudo sed -i -e 's|#PermitRootLogin yes|PermitRootLogin yes|' /etc/ssh/sshd_config
	sudo sed -i '/PubkeyAuthentication yes/a\RSAAuthentication yes' /etc/ssh/sshd_config
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


