vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

-- Asynchronous; a no-op for parsers that are already installed.
require("nvim-treesitter").install({
  "python", "javascript", "typescript", "tsx", "json", "yaml", "go", "ruby",
  "hcl", "terraform", "kotlin", "graphql", "bash", "bicep", "just",
  "dockerfile", "toml", "html", "markdown", "markdown_inline", "lua", "vim",
  "vimdoc",
})

-- Tree-sitter highlighting wherever a parser exists; regex syntax otherwise.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("berney-treesitter", { clear = true }),
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Function / class text objects (were coc-funcobj / coc-classobj).
require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
local function textobj(lhs, query)
  vim.keymap.set({ "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end, { desc = query })
end
textobj("af", "@function.outer")
textobj("if", "@function.inner")
textobj("ac", "@class.outer")
textobj("ic", "@class.inner")
