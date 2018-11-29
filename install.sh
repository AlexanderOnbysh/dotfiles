#!/bin/bash

# Utils
answer_is_yes() {
    [[ "$REPLY" =~ ^[Yy]$ ]] \
        && return 0 \
        || return 1
}

ask() {
    print_question "$1"
    read
}

ask_for_confirmation() {
    print_question "$1 (y/n) "
    read -n 1
    printf "\n"
}

execute() {
    $1 &> /dev/null
    print_result $? "${2:-$1}"
}

get_answer() {
    printf "$REPLY"
}

print_error() {
    # Print output in red
    printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
    # Print output in purple
    printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
    # Print output in yellow
    printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"

    [ "$3" == "true" ] && [ $1 -ne 0 ] \
        && exit
}

print_success() {
    # Print output in green
    printf "\e[0;32m  [✔] $1\e[0m\n"
}

# Install
declare -a FILES_TO_COPY=$(find . -maxdepth 1 -type f \
    -name ".*" \
    -not -name .DS_Store \
    -not -name .git \
    -not -name .gitignore \
    | sed -e 's|//|/|' | sed -e 's|./.|.|')

FILES_TO_COPY="$FILES_TO_COPY .mjolnir iterm"


install_colorls() {
    sudo apt-get install -y ruby-dev
    sudo gem install colorls
}

install_bat() {
    wget https://github.com/sharkdp/bat/releases/download/v0.7.1/bat-musl_0.7.1_amd64.deb
    sudo dpkg -i bat-musl_0.7.1_amd64.deb
    rm bat-musl_0.7.1_amd64.deb
}

install_zsh() {
    sudo apt install -y zsh
    sudo chsh $USER -s $(which zsh)
    export SHELL=$(which zsh)
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
}

main() {

    local i=""
    local sourceFile=""
    local targetFile=""

    for i in ${FILES_TO_COPY[@]}; do

        sourceFile="$(pwd)/$i"
        targetFile="$HOME/$(printf "%s" "$i")"

        if [ -e "$targetFile" ]; then
                if [ "$(diff -q $targetFile $sourceFile)" ]; then
                
                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then
                    rm -rf "$targetFile"
                    execute "cp -r $sourceFile $targetFile" "$targetFile → $sourceFile"
                else
                    print_error "$targetFile → $sourceFile"
                fi

            else
                print_success "$targetFile → $sourceFile"
            fi
        else
            execute "cp -r $sourceFile $targetFile" "$targetFile → $sourceFile"
        fi

    done

}

UNAME=$(uname | tr "[:upper:]" "[:lower:]")
print_info "System: $UNAME"
if [ "$UNAME" == "linux" ]; then
    execute install_colorls
    execute install_bat
    execute install_zsh
fi
unset UNAME
main
source ~/.zshrc
