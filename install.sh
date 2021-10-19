# Enable parallel downloads
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

# Install base packages
sudo pacman --needed --noconfirm -S base-devel
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
yes | makepkg -si
cd ..

# Use YAY to install all necessary packages
yay --needed --noconfirm -S nvidia xorg-server egl-wayland wget git lightdm lightdm-gtk-greeter adobe-source-code-pro-fonts plasma-desktop kscreen plasma-wayland-session dolphin neofetch exa alsa-utils kitty-git fish fisher nginx-mainline starship-git php-fpm composer python mariadb docker code filezilla android-studio google-chrome firefox opera lutris legendary steam vlc spotify ufw obs-studio virtualbox ffmpeg ktorrent timeshift-bin kdeconnect htop beekeeper-studio-bin go

# Install NVM & Composer
fisher install edc/bass
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet

# Alias LS
alias ls="exa"

# Install Node & Yarn
nvm install node
nvm use node
npm install --global yarn

# Move config files to correct directory
mv -v ./config/* ~/.config

# Change LightDM greeter
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g'

# Prepare MySQL
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Enable services
sudo systemctl enable --now mariadb.service
sudo systemctl enable lightdm

# Reboot
reboot
