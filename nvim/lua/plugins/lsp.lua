vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/b0o/SchemaStore.nvim",
  "https://github.com/stevearc/conform.nvim",
})

-- Mason installs servers that need no musl build of their own (JS, Go, JVM, Ruby gems compiled locally).
-- Native tools come from apk; see the dotfiles README.
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "pyright",
    "typescript-language-server",
    "eslint-lsp",
    "json-lsp",
    "yaml-language-server",
    "bash-language-server",
    "vim-language-server",
    "graphql-language-service-cli",
    "terraform-ls",
    "kotlin-language-server",
    "solargraph",
  },
})

-- Formatting. Format-on-save is off unless toggled with :FormatOnSaveToggle.
vim.g.format_on_save = false
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    python = { "isort", "black" },
    sh = { "shfmt" },
    lua = { "stylua" },
  },
  -- black can take over the 1 s default on a cold start.
  default_format_opts = { lsp_format = "fallback", timeout_ms = 3000 },
  format_on_save = function()
    if vim.g.format_on_save then
      return { timeout_ms = 2000 }
    end
  end,
})
vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
  vim.g.format_on_save = not vim.g.format_on_save
  vim.notify("Format on save: " .. (vim.g.format_on_save and "on" or "off"))
end, { desc = "Toggle format on save" })
