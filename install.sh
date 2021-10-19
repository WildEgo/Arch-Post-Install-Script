# Packages
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf
sudo pacman --needed --noconfirm -S base-devel
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
yes | makepkg -si
cd ..
yay --needed --noconfirm -S nvidia xorg-server egl-wayland wget git lightdm lightdm-gtk-greeter adobe-source-code-pro-fonts plasma-desktop kscreen plasma-wayland-session neofetch exa alsa-utils kitty-git fish nginx-mainline starship-git nvm php-fpm python mariadb docker code filezilla android-studio google-chrome firefox opera lutris legendary steam vlc spotify ufw obs-studio virtualbox ffmpeg ktorrent timeshift-bin kdeconnect htop beekeeper-studio-bin go

# Fish and aliases
omf install composer
omf install nvm
alias ls="exa"

# Post package commands
wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet
nvm install node
nvm use node
npm install --global yarn
curl -L https://get.oh-my.fish | fish

# Move config files to correct directory
mv -v ./config/* ~/.config

# TODO Configurate everything
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g'
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb.service
sudo systemctl enable lightdm

# Reboot
reboot
