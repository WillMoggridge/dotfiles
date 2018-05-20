" ginit.vim is run after a GUI wrapper has started

if &compatible
    set nocompatible
endif
set runtimepath+=~/.dein.vim/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.dein.vim')
    call dein#begin('~/.dein.vim')


    call dein#add('equalsraf/neovim-gui-shim')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

GuiFont Monaco:h13
GuiLinespace 8
