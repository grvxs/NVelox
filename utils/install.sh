#!/usr/bin/env bash

core_dependencies=(git nvim node npm pip3 rg)
DISTRO=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
CI=$1

yes_or_no() {
    while true; do
        read -p "$* [Y/n] " yn
        if [[ -z $yn ]]; then
            yn="y"
        else
            echo
        fi
        case $yn in
        [Yy]*)
            return 0
            ;;
        [Nn]*)
            echo "Aborted"
            return 1
            ;;
        esac
    done
}

install_core_dependencies() {
    local -n deps=$1
    cmd=$2
    uninstalled=()
    echo "Core Dependencies:"
    for dependency in "${!deps[@]}"; do
        command -v $dependency >/dev/null
        if [[ $? -eq 0 ]]; then
            echo -e "\t$dependency\tinstalled"
        else
            echo -e "\t$dependency\tnot installed"
            uninstalled+=(${deps[$dependency]})
        fi
    done
    if [[ ${#uninstalled[@]} -ne 0 ]]; then
        cmd+=" ${uninstalled[@]}"
        echo -e "\tThe following command is going to be executed:"
        echo -e "\t$ $cmd"
        yes_or_no "Continue with install?"
        if [ $? -eq 1 ]; then
            exit 1
        fi
        eval "$cmd"
    fi
}

install_extra_dependencies() {
    echo "Extra dependencies:"
    (pip3 list | grep neovim >/dev/null && echo -e "\tpynvim installed") || (echo "Installing pynvim" && pip3 install pynvim)
    (npm list --depth 1 --global neovim >/dev/null && echo -e "\tnode-client installed") || (echo "Installing node-client" && sudo npm install --global neovim)
}

# TODO: Support more distributions
install_packages() {
    case $DISTRO in
    ubuntu | debian)
        declare -A map=( ["git"]="git" ["nvim"]="neovim" ["node"]="nodejs" ["npm"]="npm" ["pip3"]="python3-pip" ["rg"]="ripgrep" )
        install_core_dependencies map "sudo apt upgrade && sudo apt update && sudo apt install"
        ;;
    arch | artix)
        declare -A map=( ["git"]="git" ["nvim"]="neovim" ["node"]="nodejs" ["npm"]="npm" ["pip3"]="python-pip" ["rg"]="ripgrep" )
        install_core_dependencies map "sudo pacman -Syu"
        ;;
    gentoo)
        declare -A map=( ["git"]="git" ["nvim"]="neovim" ["node"]="nodejs" ["npm"]="npm" ["pip3"]="pip" ["rg"]="ripgrep" )
        install_core_dependencies map "sudo emerge -av"
        ;;
    *)
        echo -n "unknown"
        return 1
        ;;
    esac
    install_extra_dependencies
}

backup() {
    yes_or_no "Do you want to backup to a custom directory?"
    if [[ $? -eq 0 ]]; then
        read -p "Enter a valid path: " DESTBAK
        eval mv -v $HOME/.config/nvim $DESTBAK
    elif [[ $? -eq 1 ]]; then
        echo "Backing up to the default backup directory (~/.config/nvim.bak)"
        mv -v $HOME/.config/nvim $HOME/.config/nvim.bak && mkdir $HOME/.config/nvim
    fi
}

clone() {
    if [[ $CI == "--ci" ]]; then
        true
    else
        if [ -d "$HOME/.config/nvim" ]; then
            backup
        fi
    fi
    git clone https://github.com/grvxs/NVelox "$HOME/.config/nvim"
    if [ ! -d "$HOME/.config/nvlx/" ]; then
        mkdir "$HOME/.config/nvlx"
        touch "$HOME/.config/nvlx/init.lua"
    fi
    if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
        git clone https://github.com/wbthomason/packer.nvim "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
    fi
    echo "Installing Plugins(This might take a while)"
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

main() {
    install_packages
    clone
}

main
