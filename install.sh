# Enable parallel downloads
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

# Change GRUB Timeout to 0
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sudo update-grub

# Install base packages
sudo pacman --needed --noconfirm -Syuu base-devel
git clone https://aur.archlinux.org/yay-git.git
cd ./yay-git
yes | makepkg -si
cd ..

# Use YAY to install all necessary packages
yay --needed --noconfirm -S nvidia xdg-user-dirs xorg-server xorg-apps xorg-xinit egl-wayland wget git lightdm lightdm-webkit2-greeter adobe-source-code-pro-fonts ttf-roboto ttf-oswald ttf-fira-sans ttf-fira-mono noto-fonts-extra ttf-fira-code plasma-desktop kscreen plasma-wayland-session kde-gtk-config dolphin neofetch exa kitty fish nginx-mainline starship php-fpm composer python mariadb postgresql docker vscodium-bin filezilla android-studio google-chrome firefox opera lutris legendary steam vlc spotify ufw obs-studio virtualbox-host-dkms virtualbox ffmpeg ktorrent timeshift-bin kdeconnect htop beekeeper-studio-bin go imagemagick sassc meson lrzip lzop p7zip unarchiver ark qemu kwallet kwallet-pam kwalletmanager pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol plasma-pa xdg-desktop-portal xdg-desktop-portal-kde youtube-dl postman-bin

# Set Fish as default Shell
chsh -s `which fish`

# Install Digital Clock Lite
git clone https://github.com/Intika-KDE-Plasmoids/plasmoid-digital-clock-lite.git
sudo chmod +x ./plasmoid-digital-clock-lite/archive/install.sh
mkdir /usr/share/plasma/plasmoids /usr/share/plasma/plasmoids/org.kde.plasma.digitalclocklite
sudo cp -fva ./plasmoid-digital-clock-lite/package/. /usr/share/plasma/plasmoids/org.kde.plasma.digitalclocklite/

# Install Cherry Theme
git clone https://github.com/nullxception/cherry-kde-theme.git
sudo chmod +x ./cherry-kde-theme/install.sh
./cherry-kde-theme/install.sh

# Install Cherrita GTK Theme
git clone https://github.com/nullxception/cherrita-gtk-theme.git
cd ./cherrita-gtk-theme
sudo meson build --prefix=/usr
sudo ninja -C build install
cd ..

# Install Glassy Chrome Plasma Theme
git clone https://gitlab.com/demsking/glassy-chrome-plasma-theme.git
sudo cp -fva ./glassy-chrome-plasma-theme/theme/. $HOME/.local/share/plasma/desktoptheme/Glassy-Chrome/

# Install Fluent Icons
git clone https://github.com/vinceliuice/Fluent-icon-theme.git
sudo chmod +x ./Fluent-icon-theme/install.sh
./Fluent-icon-theme/install.sh purple

# Install Sticky Window Snapping
git clone https://github.com/Flupp/sticky-window-snapping.git
mkdir $HOME/.local/share/kwin/ $HOME/.local/share/kwin/scripts/
cp -fva ./sticky-window-snapping/package/. $HOME/.local/share/kwin/scripts/sticky-window-snapping/

# Move wallpaper
mkdir /usr/share/wallpapers/
sudo cp -fva ./wallpapers/. /usr/share/wallpapers/

# Install KRunner Spotify Service
git clone https://github.com/MartijnVogelaar/krunner-spotify
cd ./krunner-spotify
sudo chmod +x install.sh
./install.sh
cd ..

# Install KRunner SSH Service
git clone https://gitlab.com/Programie/krunner-ssh.git
cd ./krunner-ssh
sudo chmod +x install.sh
./install.sh
cd ..

# Alias LS
alias ls="exa"

# Move config files to correct directory
cp -fva ./config/. $HOME/.config/

# Change LightDM greeter
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf

# Prepare MySQL
sudo chattr +C /var/lib/mysql/
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Prepare Postgres
chattr +C /var/lib/postgres
sudo initdb -D /var/lib/postgres/data

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-watch
cargo install diesel_cli --no-default-features --features="mysql postgresql"

# Enable services
sudo systemctl enable --now mariadb.service
sudo systemctl enable --now postgresql.service
sudo systemctl enable lightdm

# Install NVM & Composer
git clone https://github.com/edc/bass.git
cd ./bass
make install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet
cd ..

# Install Code extensions
for extension in bmalehorn.vscode-fish bmewburn.vscode-intelephense-client bradlc.vscode-tailwindcss dbaeumer.vscode-eslint DominicVonk.parameter-hints golang.go GraphQL.vscode-graphql Gruntfuggly.todo-tree higoka.php-cs-fixer IBM.output-colorizer mechatroner.rainbow-csv mikestead.dotenv ms-azuretools.vscode-docker neilbrayfield.php-docblocker octref.vetur oderwat.indent-rainbow Prisma.prisma tamasfe.even-better-toml wix.vscode-import-cost yzhang.markdown-all-in-one nullxception.cherry-theme idleberg.icon-fonts idleberg.icon-fonts miguelsolorio.fluent-icons vscode-icons-team.vscode-icons rust-lang.rust; do
    vscodium --install-extension $extension
done

mkdir $HOME/.mozilla/ $HOME/.mozilla/firefox/ $HOME/.mozilla/firefox/
cp -fva ./firefox/ $HOME/.mozilla/

# Reboot
# reboot
