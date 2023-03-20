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
ERROR=500
keycnt=0
filecnt=0
total=0
type=""
rickFile="rick.sh"


keyList=()
fileList=()
finalList=()

usage() {
    echo "Setup Rick Roll Shell in your friend's Terminal in a second!"
    echo
    echo "Syntax: rick.sh [option...]"
    echo "options:"
    echo "  -h, --help     display this help and exit"
    echo "  -h, --help     display this help and exit"
    echo "uninstall:"
    echo ""
}

Setup(){
    ehco "setup"
}

DotFolder(){
    dotFolderPath="~/.rick"
    
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

Vim(){
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

    echo "Move rick.sh to $dotVimPath folder"
    mv "$(pwd)/$rickFile" "$dotVimPath"
}

Bash(){
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
}

Zsh() {
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
}

Csh() {
    echo "Csh"
}

Ksh(){
    echo "Ksh"
}

Tcsh() {
    echo "Tcsh"
}

Fish(){
    echo "Fish"
}
#clean process directory
# rm -r $dir
# mkdir -p $dir


# --- Option processing --------------------------------------------
if [ $argcnt -eq 0 ]
then
    usage
    exit 0
fi

# --- Testing processing --------------------------------------------

Bash
Vim

optidx=0
while test $# -gt 0; do
    case "$1" in
        -h | --help )
            usage
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
            usage
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

