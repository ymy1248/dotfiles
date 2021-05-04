alias v vim
alias src 'source ~/.cshrc'
alias .. 'cd ..'
alias ... 'cd ..; cd..'
alias ll 'ls -alh'

alias script    'set AS_CMD = `which \!:1`; set AS_ST = ( $AS_CMD:as/ / / ); v $AS_ST[5]'
alias sv "source $DOTFILES_DIR/scripts/sv.tcsh"
alias go "source $DOTFILES_DIR/scripts/go.tcsh"
alias ta "source $DOTFILES_DIR/scripts/ta.tcsh"
