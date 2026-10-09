#!/bin/sh
# rustup shell setup: only when cargo's bin directory exists
if [ -d "$HOME/.cargo/bin" ]; then
    # affix colons on either side of $PATH to simplify matching
    case ":${PATH}:" in
        *:"$HOME/.cargo/bin":*)
            ;;
        *)
            # Prepending path in case a system-installed rustc needs to be overridden
            export PATH="$HOME/.cargo/bin:$PATH"
            ;;
    esac
fi
