local map = vim.keymap.set

-- "," is an alias for <Leader> (Space): every <Leader> mapping also works with ",".
map({ "n", "x" }, ",", "<Leader>", { remap = true, desc = "Leader alias" })

-- Move by display line on wrapped text, unless a count is given.
map("n", "j", "v:count ? 'j' : 'gj'", { expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { expr = true })

map("n", "<Leader>W", [[<Cmd>%s/\s\+$//e<CR><Cmd>let @/ = ''<CR>]], { desc = "Strip trailing whitespace" })
map("n", "<Leader>ev", "<Cmd>vsplit $MYVIMRC<CR>", { desc = "Edit init.lua" })
map({ "n", "x" }, "<Leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Mouse wheel + modifier: buffers and quickfix entries.
map("n", "<C-ScrollWheelDown>", "<Cmd>bnext<CR>")
map("n", "<C-ScrollWheelUp>", "<Cmd>bprevious<CR>")
map("n", "<A-ScrollWheelDown>", "<Cmd>cnext<CR>")
map("n", "<A-ScrollWheelUp>", "<Cmd>cprevious<CR>")

-- Highlight groups (syntax, Tree-sitter, LSP) under the cursor.
vim.api.nvim_create_user_command("What", "Inspect", { desc = "Show highlight groups under cursor" })
