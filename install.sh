# Enable parallel downloads
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

# Install base packages
sudo pacman --needed --noconfirm -Syuu base-devel
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
yes | makepkg -si
cd ..

# Use YAY to install all necessary packages
yay --needed --noconfirm -S nvidia xorg-server egl-wayland wget git lightdm lightdm-gtk-greeter adobe-source-code-pro-fonts plasma-desktop kscreen plasma-wayland-session dolphin neofetch exa alsa-utils kitty-git fish nginx-mainline starship-git php-fpm composer python mariadb docker code filezilla android-studio google-chrome firefox opera lutris legendary steam vlc spotify ufw obs-studio virtualbox ffmpeg ktorrent timeshift-bin kdeconnect htop beekeeper-studio-bin go

# Alias LS
alias ls="exa"

# Move config files to correct directory
cp -fva ./config/. ~/.config/

# Change LightDM greeter
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g'

# Prepare MySQL
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Enable services
sudo systemctl enable --now mariadb.service
sudo systemctl enable lightdm

# Install NVM & Composer
git clone https://github.com/edc/bass.git
cd ./bass
make install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet

# Install Node & Yarn
nvm install node
nvm use node
npm install --global yarn

# Install Code extensions
for extension in bmalehorn.vscode-fish bmewburn.vscode-intelephense-client bradlc.vscode-tailwindcss dbaeumer.vscode-eslint DominicVonk.parameter-hints golang.go GraphQL.vscode-graphql Gruntfuggly.todo-tree higoka.php-cs-fixer IBM.output-colorizer mechatroner.rainbow-csv mikestead.dotenv ms-azuretools.vscode-docker neilbrayfield.php-docblocker octref.vetur oderwat.indent-rainbow Prisma.prisma tamasfe.even-better-toml wix.vscode-import-cost yzhang.markdown-all-in-one; do
    code --install-extension $extension
done

# Reboot
# reboot
