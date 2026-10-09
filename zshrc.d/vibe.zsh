# Only alias vibe when it is installed
if (( $+commands[vibe] )); then
  alias vibe="vibe --agent plan-context7"
fi
