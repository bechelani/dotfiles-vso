#!/bin/bash
# Update pkg lists

echo "Updating package lists..."
sudo apt-get update
# zsh install
echo ''
echo "Now installing zsh..."
echo ''
sudo apt install zsh -y

# Installing git completion
echo ''
echo "Now installing git and bash-completion..."
sudo apt-get install git bash-completion -y

echo ''
echo "Now configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# oh-my-zsh install
echo ''
echo "Now installing oh-my-zsh..."
echo ''
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# vimrc vundle install
# echo ''
# echo "Now installing vundle..."
# echo ''
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Pathogen install
# echo ''
# echo "Now installing Pathogen..."
# echo ''
# mkdir -p ~/.vim/autoload ~/.vim/bundle && \
# 	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Nerdtree for vim install
# echo ''
# echo "Now installing Nerdtree for Vim..."
# echo ''
# git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# Vim color scheme install
# echo ''
# echo "Now installing vim wombat color scheme..."
# echo ''
# git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat
# mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/

# Midnight commander install
# echo ''
# echo "Now installing Midnight commander..."
# echo ''
# sudo apt-get install mc -y

# Bash color scheme
# echo ''
# echo "Now installing solarized dark WSL color scheme..."
# echo ''
# wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
# mv dircolors.256dark .dircolors

# Pull down personal dotfiles
echo ''

echo "Now pulling down bechelani dotfiles..."
git clone https://github.com/bechelani/dotfiles-vso.git ~/.dotfiles
echo ''
cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
echo ''
echo "Setting script to exectubale" && chmod +x $HOME/.dotfiles/script/bootstrap
echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
if [[ $? -eq 0 ]]
then
	echo "Successfully configured your environment with bechelani's dotfiles..."
else
	echo "bechelani's dotfiles were not applied successfully..." >&2
fi

# Setup and configure az cli
# echo ''
# read -p "Do you want to install Azure CLI? y/n (This will take some time...)" -n 1 -r
# echo ''
# if [[ $REPLY =~ ^[Yy]$ ]]
# then
# 	echo "Now installing az cli..."
#     sudo apt-get install python libssl-dev libffi-dev python-dev build-essential -y
# 	curl -L https://aka.ms/InstallAzureCli | bash
# 	exec -l $SHELL
#     if [[ $? -eq 0 ]]
#     then
#         echo "Successfully installed Azure CLI 2.0."
#     else
#         echo "Azure CLI not installed successfully." >&2
# fi
# else
#     echo "You chose not to install Azure CLI. Exiting now."
# fi

# Set default shell to zsh
echo "Now setting default shell..."

chsh -s $(which zsh); exit 0

if [[ $? -eq 0 ]]
then
	echo "Successfully set your default shell to zsh..."
else
	echo "Default shell not set successfully..." >&2
fi

echo ''
echo '	Badass VSO terminal installed!'
