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

CreateDotFolder(){
    dotFolderPath="~/.rick"

    echo "Enter path to dot folder("$IGreen"$dotFolderPath"$NC")"
    read pth
    if test -n "$pth";then
        dotFolderPath=$pth
    fi

    mkdir "$dotFolderPath"
}

SelectDotFolder(){
    dotFolderPath="~/.rick"

    echo ""
    
    echo -e -n "please enter any "$IGreen"/path/to/.folder"$NC"\n"
    while read -r dotVimPath; do
        echo "$dotVimPath"
        if test -d "$dotVimPath"; then
            echo -e ""$IGreen"$dotVimPath"$NC" found"
            break
        fi
        if [[ $notFoundCnt -eq 4 ]];then
            echo "Please enter correct file path to setup Rick Roll Shell."
            exit 404
        fi
        echo -e -n "$dotVimPath not found, please correct enter "$IGreen"/path/to/.folder"$NC"\n"
        let "notFoundCnt+=1"
    done
}

DotVim(){
    dotVimPath="~/.vim"
    if test -d "$dotVimPath"; then
        echo "defult "$IGreen".vim"$NC" found"
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
    echo "in generic" $1 $2 $3
}

Bash(){
    shellType="bash"
    bashrcPath="~/.bashrc"
    if test -f "$bashrcPath"; then
        echo "defult "$IWhite".bashrc"$NC" found"
    else
        echo -e -n "defult "$IWhite".bashrc"$NC" not found, please enter "$IWhite"/path/to/.bashrc"$NC": "
        notFoundCnt=0
        while read -r bashrcPath; do
            if test -f "$bashrcPath"; then
                echo -e ""$IWhite"$bashrcPath"$NC" found"
                break
            fi
            if [[ $notFoundCnt -eq 4 ]];then
                echo "Please enter correct file path to setup Rick Roll Shell."
                exit 404
            fi
            echo -e -n ""$IWhite"$bashrcPath"$NC" not found, please correct enter "$IWhite"/path/to/.bashrc"$NC": "
            let "notFoundCnt+=1"
        done
    fi

    GenericShell "bash" "~/.bashrc" "bashrc"
    configPath=$bashrcPath
}

Zsh() {
    shellType="zsh"
    zshrcPath="~/.zshrc"
    if test -f "$zshrcPath"; then
        echo "defult "$IWhite".zshrc"$NC" found"
    else
        echo -e -n "defult "$IWhite".zshrc$NC"" not found, please enter "$IWhite"/path/to/.zshrc"$NC": "
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
            echo -e -n ""$IWhite"$zshrcPath"$NC" not found, please correct enter "$IWhite"/path/to/.zshrc"$NC": "
            let "notFoundCnt+=1"
        done
    fi

    configPath=$bashrcPath
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

Shell(){
    echo -e -n "Select your "$IWhite"Shell type"$NC" :\n"
    echo -e -n ""$IWhite"[1]"$NC"bash "$IWhite"[2]"$NC"zsh "$IWhite"$IWhite"[3]"$NC"csh ""$IWhite"[4]"$NC"ksh "$IWhite"[5]"$NC"tcsh ""$IWhite"[6]"$NC"fish $IWhite"[q]"$NC"Quit: "
    read opt
    echo $opt

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
#clean process directory
# rm -r $dir
# mkdir -p $dir


# --- Interative Mode --------------------------------------------
if [ $argcnt -eq 0 ]
then
    echo -e "Setup "$BICyan"Rick Roll Shell "$NC"in your friend's Terminal in a second!"
    Shell
    DotFolder
    Setup
    exit 0
fi

# --- Testing processing --------------------------------------------

# Vim
# Bash

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

