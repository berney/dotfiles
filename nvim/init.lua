-- Leader must be set before any mapping is defined: mappings capture <Leader>
-- when they are created.
vim.g.mapleader = " "

require("config.options")
require("config.keymaps")

-- Under vscode-neovim, VS Code provides UI, LSP and completion.
if vim.g.vscode then
  return
end

require("config.autocmds")

-- Plugin build hooks. Registered before the first vim.pack.add() so they also
-- run when plugins are installed from the lockfile.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    -- Parsers must match the nvim-treesitter version. On "install" the plugin
    -- is not loaded yet; plugins/treesitter.lua installs parsers itself.
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

require("plugins.ui")
require("plugins.editor")
require("plugins.git")
require("plugins.treesitter")
require("plugins.completion")

require("plugins.lsp")

require("config.lsp")
