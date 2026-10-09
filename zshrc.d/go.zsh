#!/bin/sh
# Append Go bin directories to PATH, only when they exist
for dir in "$HOME/go/bin" "/usr/local/go/bin"; do
    [ -d "$dir" ] || continue
    # affix colons on either side of $PATH to simplify matching
    case ":${PATH}:" in
        *:"$dir":*)
            ;;
        *)
            export PATH="$PATH:$dir"
            ;;
    esac
done
unset dir
