#!/bin/bash

# vim config
CONFIG_VIM=$HOME/.config/nvim
VIM_DEPOT=github.com/Geam/config_neovim.git

if [[ -e $CONFIG_VIM ]]
then
    rm -rf $CONFIG_VIM
else
    CONFIG_PARENT=`dirname $CONFIG_VIM`
    if [[ ! -e $CONFIG_PARENT ]]; then
        mkdir -p $CONFIG_PARENT
    fi
fi

git clone "git@$VIM_DEPOT" $CONFIG_VIM
# because some person keep using my personal config instead of doing their own,
# they need to use the https version of this repo
if [[ "$?" -ne 0 ]]; then
    git clone "https://$VIM_DEPOT" $CONFIG_VIM
fi
if [[ -e $CONFIG_VIM ]]; then
    cd $CONFIG_VIM && \
        mkdir $CONFIG_VIM/tmp && \
        nvim +PlugInstall
fi

# i3 config
CONFIG_I3=$HOME/.i3
I3_DEPOT=github.com:Arigowin/i3_config.git

if [[ -e $CONFIG_I3 ]]
then
    rm -rf $CONFIG_I3
else
    CONFIG_PARENT=`dirname $CONFIG_I3`
    if [[ ! -e $CONFIG_PARENT ]]; then
        mkdir -p $CONFIG_PARENT
    fi
fi

git clone "git@$I3_DEPOT" $CONFIG_I3
# because some person keep using my personal config instead of doing their own,
# they need to use the https version of this repo
if [[ "$?" -ne 0 ]]; then
    git clone "https://$I3_DEPOT" $CONFIG_I3
fi
if [[ -e $CONFIG_I3 ]]; then
    cd $CONFIG_I3 && \
        mkdir $CONFIG_I3/tmp && \
        nvim +PlugInstall
fi

if [[ "$USER" != "arigowin" ]] && [[ "$USER" != "dolewski" ]]; then
    # remove my git config if it's not me
    sed -i.back '/git/d' $PERS_PATH/ln
fi

if [[ -n $SCHOOL42 ]]; then
    # create personal script dir if it doesn't exist
    if [[ ! -e "$PERS_PATH/scripts" ]]; then
        mkdir "$PERS_PATH/scripts"
    fi

    # link goindre to Music
    rm -r "$HOME/Music"
    ln -s /nfs/sgoinfre/goinfre/Music $HOME/Music

    # cause ~/Library/Caches are always sync even if you don't want..
    rm -rf $HOME/Library/Caches
    mkdir -p /tmp/$USER/Caches
    chmod 700 /tmp/$USER/Caches
    cd $HOME/Library
    ln -s /tmp/$USER/Caches

    # add exa
    curl -0 https://github.com/ogham/exa/releases/download/v0.4.0/exa-osx-x86_64.zip > $HOME/exa-osx-x86_64.zip
    unzip $HOME/exa-osx-x86_64.zip
    mv exa-osx-x86_64 $HOME/bin/exa
    rm exa-osx-x86_64.zip

    # add font for osx
    cd
    git clone https://github.com/powerline/fonts temp_fonts
    cd temp_fonts
    mkdir ~/Library/Fonts
    ./install.sh
    open /Applications/Font\ Book.app
fi
