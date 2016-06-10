#!/bin/bash

export HOST_DIR=/host
export DOTFILE_DIR=$HOST_DIR/dotfiles

if [! -d $HOST_DIR ]; then
    echo "Host directory does not exist."
    exit
fi

### Needs tidying up...

copy_aliases() {
  echo "Copy .gitconfig from host to vagrant box"
  cp $DOTFILE_DIR/.aliases /home/vagrant/.
  cp -R $DOTFILE_DIR/.aliases.d /home/vagrant/.
}

copy_tmux_config() {
  echo "Copies user's tmux config from host to vagrant box"
  cp $DOTFILE_DIR/.tmux.conf /home/vagrant/.
  cp -R $DOTFILE_DIR/.tmux.conf /home/vagrant/.
  cp -R $HOME_DIR/.tmux /home/vagrant/.
}

copy_zsh_config() {
  echo "Copies user's ZSH config"
  cp $DOTFILE_DIR/{.zshrc,.zsh-theme} /home/vagrant/.
  cp -R $HOME_DIR/.oh-my-zsh /home/vagrant/.
}

fix_home_perms() {
  echo "Fix home permissions"
  chown -R vagrant:vagrant /home/vagrant/
}

set_zshell() {
  echo "Set zshell as default shell"
  chsh -s /bin/zsh vagrant
}

copy_aliases
copy_tmux_config
copy_zsh_config
fix_home_perms

set_zshell
