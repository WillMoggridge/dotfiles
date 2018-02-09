if &compatible
  set nocompatible
endif
set runtimepath+=~/.dein.vim/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.dein.vim')
  call dein#begin('~/.dein.vim')

  call dein#add('~/.dein.vim/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('matze/vim-move')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')

  call dein#add('equalsraf/neovim-gui-shim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

GuiFont Monaco:h13
GuiLinespace 8
