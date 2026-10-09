#!/bin/sh
# Append ~/bin to PATH, only when it exists
if [ -d "$HOME/bin" ]; then
    # affix colons on either side of $PATH to simplify matching
    case ":${PATH}:" in
        *:"$HOME/bin":*)
            ;;
        *)
            export PATH="$PATH:$HOME/bin"
            ;;
    esac
fi
