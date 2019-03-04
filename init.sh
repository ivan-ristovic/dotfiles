#!/bin/bash

function inst {
	if ! apt-get -qq install "$@" > /dev/null; then
		echo " >>> ERROR WHILE INSTALLING PACKAGES:"
		echo "$@"
	fi
}


if [ "$EUID" -ne 0 ]
  then echo "> usage: sudo init.sh"
  exit 1
fi

GIT_DIR=`grep ivan-ristovic/dotfiles .git/config`;
if [ -z "$GIT_DIR" ]; then
	echo " > CRITICAL: Not in dotfiles directory. Exiting ..."
	exit 1
fi

echo " > Updating..."
apt-get -qq update > /dev/null

echo " > Configuring git..."
inst git
git config --global user.email "ivan.ristovic95@gmail.com"
git config --global user.name "ivan-ristovic"

echo " > Installing synaptic package manager ..."
inst synaptic

echo " > Installing svn ..."
inst subversion

echo " > Installing building essentials ..."
inst build-essential
inst valgrind
inst kcachegrind

echo " > Installing Qt5 ..."
inst qt5-default
inst qtcreator
inst qt5-doc qt5-doc-html qtbase5-doc-html
/sbin/ldconfig -v

echo " > Installing VS Code ..."
inst software-properties-common apt-transport-https wget
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
inst code

echo " > Installing LaTeX ..."
inst texlive-latex-recommended texlive-lang-other texlive-lang-cyrillic texlive-luatex

echo " > Cleaning up ..."
apt -qq autoremove > /dev/null

echo " > Installing zsh ..."
inst zsh
zsh --version 
usermod -s /usr/bin/zsh $(whoami)
inst powerline fonts-powerline
inst zsh-syntax-highlighting
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


echo " > Copying dotfiles ..."

INIT_IGNORES=`cat init.ignore`

for item in *; do

    IGNORED_FILE=""
    for ignored in $INIT_IGNORES; do
        if [[ "$ignored" = "$item" ]]; then
            IGNORED_FILE="$item"
        fi
    done

    if [ -n "$IGNORED_FILE" ]; then
        echo "Ignored: $item"
        continue;
    fi

    if [ -e "$HOME/.$item" ]; then
        echo "Skipped: .$item (already exists)"
        continue;
    fi

    echo "Linking: $item  to  ~/.$item"
    ln -s "$PWD/$item" "$HOME/.$item"

done


echo " > Switching to zsh ..."
chsh -s "$(which zsh)"
source ~/.zshrc
