#!/bin/bash

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
argcnt=$#
status="error" #error | key | file


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
    echo ""
    echo -e ""$BIWhite"Example:$NC"
    echo ""
    echo -e "./rick.sh $IWhite<enter>$NC # interative mode"
    echo -e "./rick.sh -s bash -f $IGreen~/.vim$NC -c $IWhite~/.bashrc$NC # setup with options"
    echo -e "./rick.sh --shell bash --folder $IGreen~/project/.vscode$NC --config $IWhite~/.bashrc$NC # setup with long options"
    echo -e "./rick.sh -s bash -f $IGreen~/.npm$NC # use defult bash configuration file ( $IWhite~/.bashrc$NC)"
}

Setup(){
    echo -e "Copy "$IRed"rickroll.sh$NC to "$IGreen"$dotFolderPath"$NC" folder"
    cp "$(pwd)/$rickFile" "$dotFolderPath/$rickFile"
    # echo "rickFilePath: $dotFolderPath/$rickFile"
    echo ""
    echo -e "Update "$IWhite"$configPath"$NC" : adding \""$BIWhite"$shellType $dotFolderPath/$rickFile"$NC"\" to the beginning of file"
    echo -e "$shellType $dotFolderPath/$rickFile\n$(cat $configPath)" > "$configPath"
    echo ""
}

Setup

CreateDotFolder(){
    echo ""
}

SelectDotFolder(){
    dotFolderPath="~/.rick"

    echo ""
    
    echo -e -n "please enter any /path/to/.folder\n"
    while read -r dotVimPath; do
        echo "$dotVimPath"
        if test -d "$dotVimPath"; then
            echo "$dotVimPath found"
            break
        fi
        if [[ $notFoundCnt -eq 4 ]];then
            echo "Please enter correct file path to setup Rick Roll Shell."
            exit 404
        fi
        echo -e -n "$dotVimPath not found, please correct enter /path/to/.vim\n"
        let "notFoundCnt+=1"
    done
}

DotVim(){
    dotVimPath="~/.vim"
    if test -d "$dotVimPath"; then
        echo "defult .vim found"
    else
        echo -e -n "defult .vim folder not found, please enter /path/to/.vim\n"
        notFoundCnt=0
        while read -r dotVimPath; do
            echo "$dotVimPath"
            if test -d "$dotVimPath"; then
                echo "$dotVimPath found"
                break
            fi
            if [[ $notFoundCnt -eq 4 ]];then
                echo "Please enter correct file path to setup Rick Roll Shell."
                exit 404
            fi
            echo -e -n "$dotVimPath not found, please correct enter /path/to/.vim\n"
            let "notFoundCnt+=1"
        done
    fi

    dotFolderPath=$dotVimPath
}

Bash(){
    shellType="bash"
    bashrcPath="~/.bashrc"
    if test -f "$bashrcPath"; then
        echo "defult .bashrc found"
    else
        echo -e -n "defult .bashrc not found, please enter /path/to/.bashrc\n"
        notFoundCnt=0
        while read -r bashrcPath; do
            echo "$bashrcPath"
            if test -f "$bashrcPath"; then
                echo "$bashrcPath found"
                break
            fi
            if [[ $notFoundCnt -eq 4 ]];then
                echo "Please enter correct file path to setup Rick Roll Shell."
                exit 404
            fi
            echo -e -n "$bashrcPath not found, please correct enter /path/to/.bashrc\n"
            let "notFoundCnt+=1"
        done
    fi

    configPath=$bashrcPath
    Setup
}

Zsh() {
    shellType="zsh"
    zshrcPath="~/.zshrc"
    if test -f "$zshrcPath"; then
        echo "defult .zshrc found"
    else
        echo -e -n "defult .zshrc not found, please enter /path/to/.zshrc\n"
        notFoundCnt=0
        while read -r zshrcPath; do
            echo "$zshrcPath"
            if test -f "$zshrcPath"; then
                echo "$zshrcPath found"
                break
            fi
            if [[ $notFoundCnt -eq 4 ]];then
                echo "Please enter correct file path to setup Rick Roll Shell."
                exit 404
            fi
            echo -e -n "$zshrcPath not found, please correct enter /path/to/.zshrc\n"
            let "notFoundCnt+=1"
        done
    fi

    Setup
}

Csh() {
    shellType="csh"
    echo "Csh"
}

Ksh(){
    shellType="ksh"
    echo "Ksh"
}

Tcsh() {
    shellType="tch"
    echo "Tcsh"
}

Fish(){
    shellType="fish"
    echo "Fish"
}
#clean process directory
# rm -r $dir
# mkdir -p $dir


# --- Interative Mode --------------------------------------------
if [ $argcnt -eq 0 ]
then
    Usage
    exit 0
fi

# --- Testing processing --------------------------------------------

Vim
Bash

# --- Options Mode --------------------------------------------
optidx=0
while test $# -gt 0; do
    case "$1" in
        -h | --help )
            Usage
            exit 0
        ;;
        --sha256)
            # echo "sha256"
            # mix hash error
            if [ "$type" = "md5sum" ]
            then
                >&2 echo "Error: Only one type of hash function is allowed."
                exit $ERROR
            fi
            status="key"
            type="sha256sum"
        ;;
        --md5)
            # echo "md5"
            # mix hash error
            if [ "$type" = "sha256sum" ]
            then
                >&2 echo "Error: Only one typeof hash function is allowed."
                exit $ERROR
            fi
            status="key"
            type="md5sum"
        ;;
        -i)
            status="file"
        ;;
        --*)
            >&2 echo "Error: Invalid arguments."
            Usage
            exit $ERROR
        ;;
        *)
            if test -z "$1"
            then
                :
            else
                if [ $status = "key" ]
                then
                    # echo "$1" > "$dir/key${keycnt}"
                    keyList+=("$1")
                    let "keycnt+=1"
                elif [ $status = "file" ]
                then
                    # echo "$1" > "$dir/file${filecnt}"
                    fileList+=("$1")
                    let "filecnt+=1"
                fi
            fi
        ;;
    esac
	shift
done


# -- Body ---------------------------------------------------------

