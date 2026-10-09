# dotfiles
bdawg's dotfiles

- Based off [this blog post][dotbot-blog-post] about [dotbot] and [dotfiles]

[dotbot-blog-post]: http://www.anishathalye.com/2014/08/03/managing-your-dotfiles/
[dotbot]: https://github.com/anishathalye/dotbot
[dotfiles]: https://dotfiles.github.io/

## Neovim

Config: `nvim/` (linked to `~/.config/nvim`). Plugins are managed by the
built-in `vim.pack`; versions are pinned in `nvim/nvim-pack-lock.json`.

Alpine prerequisites (native tools, plus build and runtime dependencies for mason's servers):

```sh
doas apk add neovim git nodejs npm build-base curl tar fzf ripgrep fd \
  lua-language-server ruff stylua shfmt prettier black py3-isort taplo \
  tree-sitter-cli ruby ruby-dev yaml-dev openjdk21-jre-headless go gopls pipx
```

`semgrep` is not packaged for Alpine; install it with `pipx install semgrep` if you enable the semgrep server.
Icons (neo-tree, lualine) need a Nerd Font set in the terminal, e.g. Windows Terminal → profile → font.

First run on a machine:

1. `./install`
2. `nvim`, confirm the plugin install prompt, wait for parsers to compile, `:qa`
3. `nvim --headless -c 'MasonToolsInstallSync' -c 'qa!'`

Updating plugins: `:lua vim.pack.update()`, review, `:write` to apply, then
commit `nvim/nvim-pack-lock.json`. Removing a plugin: delete its
`vim.pack.add()` entry, restart nvim, run `:lua vim.pack.del({ "name" })`, then commit `nvim/nvim-pack-lock.json`.
