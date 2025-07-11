#!/bin/bash
sudo pacman -S --needed --noconfirm git base-devel

# Comprobar si yay está instalado
if ! command -v yay &> /dev/null; then
    echo "yay no está instalado. Procediendo a instalar yay..."
    
    # Clonar el repositorio de yay
    git clone https://aur.archlinux.org/yay.git /tmp/yay

    # Construir e instalar yay
    cd /tmp/yay || exit
    makepkg -si --noconfirm

    echo "yay instalado correctamente."
fi



cp -r $HOME/.config/ $HOME/.config-bk/
echo "Copia de configuracion realizada en .config-bk"


cp .zshrc $HOME/.zshrc
cp -r config/* $HOME/.config/

for line in $(cat pacman-packages.txt); do
    sudo pacman -S $line --needed --noconfirm
done

for line in $(cat yay-packages.txt); do
    yay -S $line --needed --noconfirm
done


#use zsh 
chsh -s /bin/zsh

cd

systemctl enable sddm

#login screen
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh
cd ~

#fzf
git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install


#barra de erramientas
git clone https://github.com/Axenide/Ax-Shell.git ~/.config/Ax-Shell
# uwsm -- app python ~/.config/Ax-Shell/main.py > /dev/null 2>&1 & disown

#falta nvchad
#powerlevel10k

