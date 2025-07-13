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


cp $HOME/dotfiles/.zshrc $HOME/.zshrc
cp -r $HOME/dotfiles/config/* $HOME/.config/


while IFS= read -r line; do
  # Ignora líneas vacías
  [[ -z "$line" ]] && continue
  yay -S --noconfirm "$line"
done < yay-packages.txt

while IFS= read -r line; do
  # Ignora líneas vacías
  [[ -z "$line" ]] && continue
  sudo pacman -S --noconfirm "$line"
done < pacman-packages.txt

#use zsh 
chsh -s /bin/zsh

cd $HOME

sudo systemctl enable sddm

#login screen
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh
cd $HOME

#fzf
git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install


#barra de erramientas
git clone https://github.com/Axenide/Ax-Shell.git ~/.config/Ax-Shell
# uwsm -- app python ~/.config/Ax-Shell/main.py > /dev/null 2>&1 & disown

#falta nvchad
#powerlevel10k

