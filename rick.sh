#!/usr/bin/env bash

# ------------------------------------------------------------------
# [Author] Title
#          Description
#
#          This script uses shFlags -- Advanced command-line flag
#          library for Unix shell scripts.
#          http://code.google.com/p/shflags/
#
# Dependency:
#     http://shflags.googlecode.com/svn/trunk/source/1.0/src/shflags
# ------------------------------------------------------------------


# --- Global Variables --------------------------------------------

# for input status
status="error"
# for setting
rickFile="rickroll.sh"
dotFolderPath="~/.vim"
shellType="bash"
configPath="~/.bashrc"

# --- Color Variables --------------------------------------------
RED='\033[0;31m'
BIWhite='\033[1;97m' 
IGreen='\033[0;92m'
IRed='\033[0;91m'
IWhite='\033[0;97m'
BICyan='\033[1;96m'  
NC='\033[0m' # No Color

# Usage funciton
Usage() {
    echo -e "Setup "$BICyan"Rick Roll Shell "$NC"in your friend's Terminal in a second!"
    echo
    echo -e ""$BIWhite"Syntax:$NC rick.sh [options...]"
    echo ""
    echo -e ""$BIWhite"Options:$NC"
    echo "  -h, --help     display this help and exit"
    echo -e "  -s, --shell    select shell type $IWhite{bash,zsh,csh,ksh,tcsh,fish}$NC"
    echo -e "  -f, --folder   select dot folder to hide rickroll.sh (defult: $IGreen~/.vim$NC folder)"
    echo "  -c, --config   select shell configuration file"
    echo -e "  -r, --roll     run $IRed"rickroll.sh$NC""
    echo ""
    echo -e ""$BIWhite"Description:$NC"
    echo ""
    echo -e "Add \""$BIWhite"\$SHELL /path/to/.FOLDER/$rickFile"$NC"\" to the beginning of shell configuration file"
    echo -e ""$IRed"rickroll.sh$NC will be copy to "$IGreen"/path/to/.FOLDER"$NC" folder"
    echo ""
    echo -e ""$BIWhite"Example:$NC"
    echo ""
    echo -e "./rick.sh $IWhite<enter>$NC # interative mode"
    echo -e "./rick.sh -s zsh -f $IGreen~/.vim$NC -c $IWhite~/.zshrc$NC # setup with options"
    echo -e "./rick.sh --shell bash --folder $IGreen~/project/.vscode$NC --config $IWhite~/.bashrc$NC # setup with long options"
    echo -e "./rick.sh -s bash -f $IGreen~/.npm$NC # use defult bash configuration file ( $IWhite~/.bashrc$NC)"
}

Setup(){
    echo -e "\nStart setup process ... "

    echo -e "Copy "$IRed"rickroll.sh$NC to "$IGreen"$dotFolderPath"$NC" folder"
    eval "cp $(pwd)/$rickFile $dotFolderPath/$rickFile"

    echo -e "Update "$IWhite"$configPath"$NC" : adding \""$BIWhite"$shellType $dotFolderPath/$rickFile"$NC"\" to the end of file"
    eval "echo $shellType $dotFolderPath/$rickFile >> $configPath"
    
    echo -e "Finish setup !"
}

CreateDotFolder(){
    dotFolderPath=""

    echo -e -n "Enter path to dot folder (defult: "$IGreen~/.rick$NC") "
    read pth
    if [ -d "$pth" ]; then
        dotFolderPath=$pth
    else 
        if [ -n "$pth" ]; then
            dotFolderPath=$pth
        else
            dotFolderPath="~/.rick"
        fi
        eval "mkdir -p "$dotFolderPath""
    fi
}

SelectDotFolder(){
    dotFolderPath="~/.rick"

    echo ""
    
    echo -e -n "please enter any "$IGreen"/path/to/.folder"$NC" "
    while read -r dotFolderPath; do
        if test -d "$dotFolderPath"; then
            echo -e ""$IGreen"$dotFolderPath"$NC" found"
            break
        fi
        if [[ $notFoundCnt -eq 4 ]];then
            echo "Please enter correct file path to setup Rick Roll Shell."
            exit 404
        fi
        echo -e -n "$dotFolderPath not found, please correct enter "$IGreen"/path/to/.folder"$NC" "
        let "notFoundCnt+=1"
    done
}

DotVim(){
    dotVimPath="~/.vim"
    if [ ! -d "$dotVimPath" ]
    then
        echo -e "defult "$IGreen".vim"$NC" found"
    else
        echo -e -n "defult "$IGreen".vim"$NC" folder not found, please enter "$IGreen"/path/to/.vim"$NC": "
        notFoundCnt=0
        while read -r dotVimPath; do
            if test -d "$dotVimPath"; then
                echo -e ""$IGreen"$dotVimPath"$NC" found"
                break
            fi
            if [[ $notFoundCnt -eq 4 ]];then
                echo "Please enter correct file path to setup Rick Roll Shell."
                exit 404
            fi
            echo -e -n "$dotVimPath not found, please correct enter "$IGreen"/path/to/.vim"$NC": "
            let "notFoundCnt+=1"
        done
    fi

    dotFolderPath=$dotVimPath
}

DotFolder(){
    echo -e -n ""$IWhite"[1]"$NC"Select $IGreen~/.vim$NC folder. "$IWhite"[2]"$NC"Create dot folder. "$IWhite"[3]"$NC"Select dot folder. "$IWhite"[q]"$NC"Quit: "
    read opt

    case "$opt" in
        1 )
            DotVim
        ;;
        2 )
            CreateDotFolder
        ;;
        3 )
            SelectDotFolder
        ;;
        * )
            exit 0
        ;;
    esac
}

GenericShell(){
    shellType=$1
    configPath=$2
    configName=$3

    if [ ! -f "$configPath" ]
    then
        echo -e "defult "$IWhite".$configName"$NC" found"
    else
        echo -e -n "defult "$IWhite".$configName"$NC" not found, please enter "$IWhite"/path/to/.$configName"$NC": "
        notFoundCnt=0
        while read -r configPath; do
            if test -f "$configPath"; then
                echo -e ""$IWhite"$configPath"$NC" found"
                break
            fi
            if [[ $notFoundCnt -eq 4 ]];then
                echo "Please enter correct file path to setup Rick Roll Shell."
                exit 404
            fi
            echo -e -n ""$IWhite"$configPath"$NC" not found, please correct enter "$IWhite"/path/to/.$configName"$NC": "
            let "notFoundCnt+=1"
        done
    fi
}

Bash(){
    GenericShell "bash" "~/.bashrc" "bashrc"
}

Zsh() {
    GenericShell "zsh" "~/.zshrc" "zshrc"
}

Csh() {
    GenericShell "csh" "~/.cshrc" "cshrc"
}

Ksh(){
    GenericShell "ksh" "~/.kshrc" "kshrc"
}

Tcsh() {
    GenericShell "tcsh" "~/.tcshrc" "tcshrc"
}

Fish(){
    GenericShell "fish" "~/.config/fish/config.fish" "config.fish"
    
}

Shell(){
    echo -e -n "Select your "$IWhite"Shell type"$NC" :\n"
    echo -e -n ""$IWhite"[1]"$NC"bash "$IWhite"[2]"$NC"zsh "$IWhite"$IWhite"[3]"$NC"csh ""$IWhite"[4]"$NC"ksh "$IWhite"[5]"$NC"tcsh ""$IWhite"[6]"$NC"fish $IWhite"[q]"$NC"Quit: "
    read opt

    case "$opt" in
        1 )
            Bash
        ;;
        2 )
            Zsh
        ;;
        3 )
            Csh
        ;;
        4 )
            Ksh
        ;;
        5 )
            Tcsh
        ;;
        6 )
            Fish
        ;;
        * )
            exit 0
        ;;
    esac
}


# --- Interative Mode --------------------------------------------
if [ $# -eq 0 ]
then
    echo -e "Setup "$BICyan"Rick Roll Shell "$NC"in your friend's Terminal in a second!\n"
    Shell
    echo ""
    DotFolder
    Setup
    exit 0
fi


# --- Options Mode --------------------------------------------
while test $# -gt 0; do
    case "$1" in
        -h | --help )
            Usage
            exit 0
        ;;
        -r | --roll )
            ./rickroll.sh
            exit 0
        ;;
        -s | --shell )
            status="shell"
        ;;
        -f | --folder )
            status="folder"
        ;;
        -c | --config )
            status="config"
        ;;
        -* | --*)
            >&2 echo -e ""$RED"Error:"$NC" Invalid arguments.\n"
            Usage
            exit $ERROR
        ;;
        *)
            case "$status" in
                shell )
                    shellType="$1"
                ;;
                folder )
                    dotFolderPath="$1"
                ;;
                config )
                    configPath="$1"
                ;;
            esac
        ;;
    esac
	shift
done

Setup


