# amun-development: asdf shims + user-local binaries (claude lives in ~/.local/bin)
[ -d "$HOME/.asdf/shims" ] && export PATH="$HOME/.asdf/shims:$PATH"
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) [ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin" ;;
esac
