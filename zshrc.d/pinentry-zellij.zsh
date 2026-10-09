# Use pinentry-zellij for ssh/sudo passphrase prompts, only when it is installed
if [ -x "$HOME/.local/bin/pinentry-zellij" ]; then
  export SSH_ASKPASS="$HOME/.local/bin/pinentry-zellij"
  export SSH_ASKPASS_REQUIRE=prefer
  export SUDO_ASKPASS="$HOME/.local/bin/pinentry-zellij"
fi

# Is interactive shell, not a Claude Code shell, has a TTY on stdout, and gpg is installed
if [[ -o interactive && -z "$CLAUDECODE" && -t 1 ]] && (( $+commands[gpg-connect-agent] )); then
  export GPG_TTY="$(tty)"
  gpg-connect-agent updatestartuptty /bye > /dev/null
fi
