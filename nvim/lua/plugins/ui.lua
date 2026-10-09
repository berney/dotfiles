vim.pack.add({
  "https://github.com/crusoexia/vim-monokai",
  "https://github.com/sainnhe/sonokai",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
})

vim.g.sonokai_better_performance = 1
vim.cmd.colorscheme("monokai")

require("lualine").setup({
  options = { theme = "auto" },
  tabline = { lualine_a = { "buffers" } },
})

require("ibl").setup({ indent = { char = "┊" } })
