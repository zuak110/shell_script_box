#!/bin/bash

BASH_VERSION="v 0.0.1"

SYSTEM_TEMP='unknow'
BASEPATH=$(cd `dirname $0`; pwd)

RED_COLOR='\033[1;31m'  
YELOW_COLOR='\033[1;33m' 
BLUE_COLOR='\033[1;34m'
GREEN_COLOR='\033[1;32m'  
RESET='\033[0m'

#cat banner

printf "%s\n" " "
echo "========== Linux environment deployment one-key shell ${BASH_VERSION} =========="

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

echo " -------------------------------------------"
echo -e "${YELOW_COLOR} Prepare to upgrade system and ${PM} version ... ${RESET}"
sudo ${PM} upgrade 

echo -e "${YELOW_COLOR} Prepare to install development tools ...  ${RESET}"
if [ ${PM} = "apt" ]; then
    sudo ${PM} install build-essential -y
else
    sudo ${PM} grouplist -y
    sudo ${PM} groupinstall "GNOME Desktop" -y
    sudo ${PM} groupinstall "Development Tools" -y
    sudo ${PM} install cscope -y
    sudo ${PM} install ctags -y
    sudo ${PM} install screen -y
    sudo ${PM} install grub-customizer -y
    sudo ${PM} install ncurses-devel -y
    sudo ${PM} install openssl-devel -y
    sudo ${PM} install gcc -y
    sudo ${PM} install gcc-c++ -y
    sudo ${PM} install tmux -y
    sudo ${PM} install cscope -y
    sudo ${PM} install ctags -y
    sudo ${PM} install screen -y
    sudo ${PM} install grub-customizer -y
    sudo ${PM} install ncurses-devel -y
    sudo ${PM} install openssl-devel -y
    sudo ${PM} install gcc -y
    sudo ${PM} install gcc-c++ -y
    sudo ${PM} install patch -y
    sudo ${PM} install *lzo* -y
    sudo ${PM} install *elf* -y
    sudo ${PM} install vim-enhanced -y
    sudo ${PM} install git -y
    sudo ${PM} install bison -y
    sudo ${PM} install readline-devel -y
    sudo ${PM} install snappy-devel -y
    sudo ${PM} install wget -y
    sudo ${PM} install tcl -y
    sudo ${PM} install tcl-devel -y
    sudo ${PM} install tk -y
    sudo ${PM} install tk-devel -y
    sudo ${PM} install git-email -y
    sudo ${PM} install autoconf -y
    sudo ${PM} install automake -y
    sudo ${PM} install zlib-devel -y
    sudo ${PM} install bzip2-devel -y
    sudo ${PM} install openssl-devel -y
    sudo ${PM} install ncurses-devel -y
    sudo ${PM} install sqlite-devel -y
    sudo ${PM} install readline-devel -y
    sudo ${PM} install tk-devel -y
    sudo ${PM} install gdbm-devel -y
    sudo ${PM} install db4-devel -y
    sudo ${PM} install libpcap-devel -y
    sudo ${PM} install xz-devel -y
    sudo ${PM} install libffi-devel -y
fi

echo -e "${YELOW_COLOR} Prepare to install useful tools ...  ${RESET}"
if [ ${PM} = "apt" ]; then
    sudo ${PM} install vim -y
    sudo ${PM} install git -y
    sudo ${PM} install tree -y
    sudo ${PM} install wget -y
    sudo ${PM} install w -y
    sudo ${PM} install nmon -y
    sudo ${PM} install ncdu -y
    sudo ${PM} install slurm -y
    sudo ${PM} install findmnt -y
    sudo ${PM} install dstat -y
    sudo ${PM} install saidar -y
    sudo ${PM} install ss -y
    sudo ${PM} install ccze -y
else
    sudo ${PM} install vim -y
    sudo ${PM} install git -y
    sudo ${PM} install tree -y
    sudo ${PM} install wget -y
    sudo ${PM} install w -y
    sudo ${PM} install nmon -y
    sudo ${PM} install ncdu -y
    sudo ${PM} install slurm -y
    sudo ${PM} install findmnt -y
    sudo ${PM} install dstat -y
    sudo ${PM} install saidar -y
    sudo ${PM} install ss -y
    sudo ${PM} install ccze -y
fi

PYTHON_VER="3.6.5"
if [ ${PM} = "yum" ]; then
    CHECK_COMMAND="python3"
    URL="https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz"
    Check_Command_Exist ${CHECK_COMMAND}
    if [ $? -ne 1 ]; then
        echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} and it has been installed. ${RESET}"
    else
        echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
        wget ${URL}
        SAVE_PATH="/usr/local/python3"
        if [ !-e ${SAVE_PATH} ]; then
            mkdir ${SAVE_PATH}
        fi
        tar -xvJf  Python-${PYTHON_VER}.tar.xz
        cd Python-${PYTHON_VER}
        ./configure --prefix=${SAVE_PATH}
        make && make install
        ln -s ${SAVE_PATH}/bin/python3 /usr/bin/python3
        ln -s ${SAVE_PATH}/bin/pip3 /usr/bin/pip3

        CHECK_COMMAND="pip"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo ""
        else
            echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
            sudo ${PM} install epel-release -y
            sudo ${PM} install python-pip -y
        fi
        
        CHECK_COMMAND="python3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="pip3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="python"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="pip"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
    fi
else
    CHECK_COMMAND="python3"
    URL="https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tar.xz"
    Check_Command_Exist ${CHECK_COMMAND}
    if [ $? -ne 1 ]; then
        echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} and it has been installed. ${RESET}"

        CHECK_COMMAND="pip3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo ""
        else
            echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
            sudo ${PM} install python3-pip python3-dev build-essential -y 
        fi
        CHECK_COMMAND="pip"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo ""
        else
            echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
            sudo ${PM} install python-pip python-dev build-essential -y 
        fi

        CHECK_COMMAND="pip3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="python"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} and it has been installed. ${RESET}"
        fi
        CHECK_COMMAND="pip"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        
    else
        echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
        wget ${URL}
        SAVE_PATH="/usr/local/python3"
        if [ !-e ${SAVE_PATH} ]; then
            mkdir ${SAVE_PATH}
        fi
        tar -xvJf  Python-${PYTHON_VER}.tar.xz
        cd Python-${PYTHON_VER}
        ./configure --prefix=${SAVE_PATH}
        make && make install
        ln -s ${SAVE_PATH}/bin/python3 /usr/bin/python3
        ln -s ${SAVE_PATH}/bin/pip3 /usr/bin/pip3

        CHECK_COMMAND="pip3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo ""
        else
            echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
            sudo ${PM} install python3-pip python3-dev build-essential -y 
        fi
        CHECK_COMMAND="pip"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo ""
        else
            echo -e "${YELOW_COLOR} Prepare to install ${CHECK_COMMAND} ...  ${RESET}"
            sudo ${PM} install python-pip python-dev build-essential -y 
        fi
        
        CHECK_COMMAND="python3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="pip3"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="python"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
        CHECK_COMMAND="pip"
        Check_Command_Exist ${CHECK_COMMAND}
        if [ $? -ne 1 ]; then
            echo -e >&2 "${GREEN_COLOR} Require ${CHECK_COMMAND} successfully installed. ${RESET}"
        fi
    fi
fi   

cd ${BASEPATH}

sudo wget https://raw.githubusercontent.com/zuak110/shell_script_box/dev/banner > /dev/null 2>&1
sudo cat banner
sudo rm -f banner

#printf "%s\n" " "
#sudo sed -i -e 's|passwd: 123456|passwd: 654321|' test.conf
#var="passwd: 8842"
#sudo sed -i "/^passwd:/c${var}" test.conf
#sudo sed -i '$a net:XXX.XXX.XXX.XXX' test.conf
#sudo sed -i '$d' test.conf

#Check_Command_Exist python
#if [ $? -ne 1 ]; then
#    echo "TRUE"
#else
#    echo "FALSE"
#fi

printf "%s\n" " "
echo -e "${GREEN_COLOR} [DONE] Congratulations!  ${RESET}"
