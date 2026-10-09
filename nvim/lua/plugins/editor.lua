-- AnsiEsc bundles cecutil.vim, whose <Leader>swp mapping would make <Leader>s
-- wait for timeoutlen.
vim.g.no_cecutil_maps = 1

vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
  "https://github.com/stevearc/aerial.nvim",
  "https://github.com/dhruvasagar/vim-table-mode",
  "https://github.com/jeetsukumaran/vim-indentwise",
  "https://github.com/powerman/vim-plugin-AnsiEsc",
  "https://github.com/djpohly/vim-execline",
})

local map = vim.keymap.set

-- fzf-lua: lists previously provided by coc-lists.
local fzf = require("fzf-lua")
fzf.setup({})
map("n", "<Leader>a", fzf.diagnostics_workspace, { desc = "Diagnostics (all buffers)" })
map("n", "<Leader>o", fzf.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<Leader>s", fzf.lsp_live_workspace_symbols, { desc = "Workspace symbols" })
map("n", "<Leader>:", fzf.commands, { desc = "Commands" })

-- neo-tree: sidebar explorer (was coc-explorer). <Leader>ee skips the
-- timeoutlen wait that <Leader>e has because of <Leader>er / <Leader>ev.
require("neo-tree").setup({})
map("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
map("n", "<Leader>ee", "<Cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
map("n", "<Leader>er", "<Cmd>Neotree reveal<CR>", { desc = "Reveal current file" })

-- aerial: symbol outline (was vista.vim).
require("aerial").setup({})
map("n", "<Leader>v", "<Cmd>AerialToggle!<CR>", { desc = "Toggle symbol outline" })
