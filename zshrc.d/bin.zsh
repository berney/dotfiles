#!/bin/sh
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"$HOME/bin":*)
        ;;
    *)
        # Appending path
        export PATH="$PATH:$HOME/bin"
        ;;
esac
