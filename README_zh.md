# Rick Roll Shell

[English](https://github.com/jason810496/Rick-Roll-Shell)

三秒內常見的 Shell 中設定 **Rick Roll** !

當你朋友登入 Shell 時就會被 Rick Roll :-)

![Demo Gif](https://raw.githubusercontent.com/jason810496/Rick-Roll-Shell/Demo/demo.gif)

## 如何使用
```
Setup Rick Roll Shell in your friend's Terminal in a second!

Syntax: rick.sh [options...]

Options:
  -h, --help     display this help and exit
  -s, --shell    select shell type {bash,zsh,csh,ksh,tcsh,fish}
  -f, --folder   select dot folder to hide rickroll.sh (defult: ~/.vim folder)
  -c, --config   select shell configuration file
  -r, --roll     run rickroll.sh

Description:

Add "$SHELL /path/to/.FOLDER/rickroll.sh" to the beginning of shell configuration file
rickroll.sh will be copy to /path/to/.FOLDER folder

Example:

./rick.sh <enter> # interative mode
./rick.sh -s zsh -f ~/.vim -c ~/.zshrc # setup with options
./rick.sh --shell bash --folder ~/project/.vscode --config ~/.bashrc # setup with long options
./rick.sh -s bash -f ~/.npm # use defult bash configuration file ( ~/.bashrc)
```