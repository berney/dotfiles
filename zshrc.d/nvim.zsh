# Use Neovim as vi and as the default editor, falling back to Vim
if (( $+commands[nvim] )); then
  alias vi=nvim
  export EDITOR=nvim
elif (( $+commands[vim] )); then
  alias vi=vim
  export EDITOR=vim
fi
