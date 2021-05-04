# clean up dotfiles
rm -f ~/.cshrc
rm -f ~/.vimrc
rm -f ~/.alias
rm -f ~/.tmux.conf

# link files
ln -s $PWD/setup/vimrc ~/.vimrc
ln -s $PWD/setup/cshrc.tcsh ~/.cshrc
ln -s $PWD/setup/alias.tcsh ~/.alias
ln -s $PWD/setup/tmux.conf ~/.tmux.conf

setenv DOTFILES_DIR "$PWD"
source ~/.cshrc
