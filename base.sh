#!/bin/bash
# include this boilerplate
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

start=${1:-"start"}

jumpto $start

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
        	start:
            	echo ********** APP LIST **********
            	echo "1> nvidia Drivers"
            	echo "2> Desktop Environment/ Window Manager"
            	echo "3> Login/Display Manager"
            	echo "4> Multimedia Apps (Audio/Video)"
            	echo "5> Development Tools (Build Tools + Languages)"
            	echo "6> Productivity Apps"
            	echo "7> Terminal setup"
            	echo "8> Exit"
            	read input1
            
            	if [[ "$input1" -eq 1 ]]
            		echo IMPORTANT NOTE: Do not install nvidia drivers if you are using virtual machine without nvidia gpu passthrough which is only available in Desktop.
            		echo If you are using this on laptop/Desktop without virtual machine you are safe to install it
            		sudo pacman -S nvidia-lts nvidia-utils nvidia-settings
            		cd /etc/
            		sudo cp mkinitcpio.conf mkinitcpiobackup.conf
            		sed -i '/MODULES/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' mkinitcpio.conf
            		jumpto start
            	elif [[ "$input1" -eq 2 ]]
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
				echo GNOME Desktop Environmment Installation
				sudo pacman -S gnome --noconfirm
				sudo pacman -R
				jumpto start
		
						elif [[ "$deinput" -eq 3 ]] ;then
				echo "KDE Desktop Environment Installation"
				jumpto start
			elif [[ "$deinput" -eq 4 ]] ;then
				echo "Cinnamon Desktop Environment Installation"
				jumpto start
			elif [[ "$deinput" -eq 5 ]] ;then
				echo "Deepin Desktolp Environment Installation"
				jumpto start
			elif [[ "$deinput" -eq 6 ]] ;then
				echo "LXDE Installation"
				jumpto start
			elif [[ "$deinput" -eq 7 ]] ;then
				echo "LXQT Desktop Environment Installation"
				jumpto start
			elif [[ "$deinput" -eq 8 ]] ;then
				echo "Mate Desktop Environment Installation"
				jumpto start
			elif [[ "$deinput" -eq 9 ]] ;then
				echo "XFCE Desktop Environment Installation"
				jumpto start
			elif [[ "$deinput" -eq 10 ]] ;then
				echo "i3 Window Manager Installation"
				jumpto start
			elif [[ "$deinput" -eq 11 ]] ;then
				echo "bspwm Installation"
				jumpto start
			elif [[ "$deinput" -eq 12 ]] ;then
				echo "awesome window Manager Installation"
				jumpto start		            
	    		fi
	    
            	elif [[ "$input1" -eq 3 ]] ;then
            		echo Login / Display Managers
                	echo i> Lightdm
            		echo ii> GDM
            		echo iii> SDDM
            		echo Enter the Option :
            		read $dminput
            	
#################################### LIGHT DM ############################################            	
            		if [[ "$dminput" -eq 1 ]] ;then
            			if [[ "$deinput" -eq 6 || "$deinput" -eq 9 || "$deinput" -eq 10 || "$deinput" -eq 11 || "$deinput" -eq 12 ]] ;then
            				sudo pacman -S lightdm-webkit2-greeter numlockx --noconfirm
            				yay -S lightdm-webkit2-theme-glorious
            				cd /etc/lightdm
            				sudo sed -i '/#greeter-session=/c\greeter-session=lightdm-webkit2-greeter' lightdm.conf
            				sudo sed -i '/#greeter-setup-script=/c\greeter-setup-script=/usr/bin/numlockx on' lightdm.conf
            				
            				if [[ "$deinput" -eq 10 || "$deinput" -eq 11 || "$deinput" -eq 12 ]] ;then
            					sudo sed -i '/#autologin-session=/c\autologin-session=i3' lightdm.conf
            				fi
            				
            				sudo sed -i '/webkit_theme        = antergos/c\webkit_theme        = glorious' lightdm-webkit2-greeter.conf
            				sudo systemctl enable lightdm.service
            				jumpto start
            			elif [[ "deinput" -eq 1 || "deinput" -eq 2 || "deinput" -eq 4 || "deinput" -eq 8 ]] ;then
            				echo Using LightDM with Gnome based Desktop Environment will not give full features of gnome.
            				echo It is recommended to use GDM with gnome based Desktop Environemnt.
            				echo If you still want to install lightdm . Press Y -
            				read $ldminput
            				if [[ "$ldminput" = "Y" || "$ldminput" = "y" ]] ;then
            					sudo pacman -S lightdm-webkit2-greeter numlockx --noconfirm
            					yay -S lightdm-webkit2-theme-glorious
            					cd /etc/lightdm
            					sudo sed -i '/#greeter-session=/c\greeter-session=lightdm-webkit2-greeter' lightdm.conf
            					sudo sed -i '/#greeter-setup-script=/c\greeter-setup-script=/usr/bin/numlockx on' lightdm.conf
            					sudo sed -i '/webkit_theme        = antergos/c\webkit_theme        = glorious' lightdm-webkit2-greeter.conf
            					sudo systemctl enable lightdm.service
            					jumpto start
            				fi
            			elif 
            	
################################## GDM #########################################################            	
            		elif [[ "$dminput" -eq 2 ]] ;then
            			sudo pacman -S gdm --noconfirm
            			sudo systemctl enable gdm.service
				jumpto start
################################## SDDM ########################################################            		
            		elif [[ "$dminput" -eq 3 ]] ;then
            			sudo pacman -S sddm
            			yay -S sddm-archlinux-theme-git
            			sudo cp /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf
            			cd /etc/
            			sudo sed -i '/Numlock=/c\Numlock=on' sddm.conf
            			sudo sed -i '/Current=/c\Current=archlinux' sddm.conf
            			sudo systemctl enable sddm.service
				jumpto start
            	
            	
	    	elif [[ "$input1" -eq 4 ]] ;then
	    		echo "Multimedia Installations"
	    		sudo pacman -S mpv vlc ffmpeg
	    		yay -S mps-youtube-git
	    		yay -S youtube-viewer
			jumpto start
	    
	    	elif [[ "$input1" -eq 5 ]] ;then
	    		echo "Development Tools Installation"
	    	
	    		sudo pacman -S cmake clang nodejs npm jdk11-openjdk
	    		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
			# input 1
			source $HOME/.cargo/env
			source ~/.profile
			jumpto start
	    	
	    	elif [[ "$input1" -eq 6 ]] ;then
	    		echo Productivity Apps Installation
	    		yay -S notion-app-enhanced whatsapp-for-linux newsflash 
			jumpto start
	    	
	    	elif [[ "$input1" -eq 7 ]] ;then
	    		echo "Terminal Setup"
			jumpto start
	    	
	    	elif [[ "$input1" -eq 8 ]] ;then
	    		jumpto end
	    		
	    		
end:
