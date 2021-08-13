#!/bin/bash

#1 arch
#2 yum
#3 emerge
#4 zypp
#5 debian

pacman="pacman"
dnf="dnf"
emerge="emerge"
zypp="zypp"
apt="apt-get"

declare -A osInfo;
osInfo[/etc/redhat-release]=dnf
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        echo Package manager Found !: ${osInfo[$f]}
        if [[ "${osInfo[$f]}" = "$pacman" ]] ;then
            echo ********** APP LIST **********
            echo i> nvidia Drivers
            echo ii> Login/Display Manager
            echo iii> Desktop Environment/ Window Manager
            echo iv> Multimedia Apps (Audio/Video)
            echo v> Development Tools (Build Tools + Languages)
            echo vi> Productivity Apps  
            echo vii> Terminal setup
            read input1
            
            if [[ "$input1" -eq 1 ]]
            	sudo pacman -S nvidia-lts nvidia-utils nvidia-settings
            	cd /etc/
            	sudo cp mkinitcpio.conf mkinitcpiobackup.conf
            	sed -i '/MODULES/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' mkinitcpio.conf
            elif [[ "$input1" -eq 2 ]]
            	sudo pacman -S lightdm lightdm-webkit2-greeter lightdm-webkit2 numlockx --noconfirm
            	cd /etc/lightdm
            	sed -i '/#greeter-session=/c\greeter-session=lightdm-webkit2-greeter' lightdm.conf
            	sed -i '/#greeter-setup-script=/c\greeter-setup-script=/usr/bin/numlockx on' lightdm.conf
            	sed -i '/#autologin-session=/c\autologin-session=i3' lightdm.conf
            	sudo systemctl enable lightdm.service
            elif [[ "$input1" -eq 3 ]] ;then
            	echo ********** Desktop Environments **********
            	echo i> Budgie
            	echo ii> Gnome
            	echo iii> KDE
            	echo iv> Cinnamon
            	echo v> Deepin
            	echo vi> LXDE
            	echo vii> LXQT
            	echo viii> Mate
            	echo ix> XFCE
            	echo x> i3
            	echo xi> bspwm
            	echo xii> awesome
            	read deinput
         
            	if [[ "$deinput" -eq 1 ]] ;then
		elif [[ "$deinput" -eq 2 ]] ;then
		elif [[ "$deinput" -eq 3 ]] ;then
		elif [[ "$deinput" -eq 4 ]] ;then
		elif [[ "$deinput" -eq 5 ]] ;then
		elif [[ "$deinput" -eq 6 ]] ;then
		elif [[ "$deinput" -eq 7 ]] ;then
		elif [[ "$deinput" -eq 8 ]] ;then
		elif [[ "$deinput" -eq 9 ]] ;then
		elif [[ "$deinput" -eq 10 ]] ;then
		elif [[ "$deinput" -eq 11 ]] ;then
		elif [[ "$deinput" -eq 12 ]] ;then		            
	    
	    elif [[ "$input1" -eq 4 ]] ;then
	    	echo Multimedia Installations
	    
	    elif [[ "$input1" -eq 5 ]] ;then
	    	echo Development Tools Installation
	    	
	    elif [[ "$input1" -eq 6 ]] ;then
	    	echo Productivity Apps Installation
	    	
