#!/bin/sh
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"$HOME/go/bin":*)
        ;;
    *)
        # Appending path
        export PATH="$PATH:$HOME/go/bin"
        ;;
esac
