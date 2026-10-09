local augroup = vim.api.nvim_create_augroup("berney", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Highlight overrides, re-applied whenever the colorscheme changes.
local function set_highlights()
  vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "darkgreen", ctermbg = "darkgreen" })
  vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = "#ff0000", ctermfg = "red" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#c4384b" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#c4ab39" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#8cf8f7" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#a6dbff" })
end
autocmd("ColorScheme", { group = augroup, callback = set_highlights })
set_highlights()

-- Trailing whitespace: highlighted everywhere except just before the cursor
-- while typing. Only in normal file buffers.
local function whitespace_match(pattern)
  if vim.w.extra_ws_id then
    pcall(vim.fn.matchdelete, vim.w.extra_ws_id)
    vim.w.extra_ws_id = nil
  end
  if vim.bo.buftype ~= "" then
    return
  end
  vim.w.extra_ws_id = vim.fn.matchadd("ExtraWhitespace", pattern)
end
autocmd({ "BufWinEnter", "InsertLeave" }, {
  group = augroup,
  callback = function()
    whitespace_match([[\s\+$]])
  end,
})
autocmd("InsertEnter", {
  group = augroup,
  callback = function()
    whitespace_match([[\s\+\%#\@<!$]])
  end,
})

autocmd("FileType", {
  group = augroup,
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
  end,
})

-- JSON: hide quotes on every line except the cursor line (in all modes).
autocmd("FileType", {
  group = augroup,
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ""
  end,
})
