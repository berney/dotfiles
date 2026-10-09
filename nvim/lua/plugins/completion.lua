vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  -- Tagged releases ship the prebuilt Rust fuzzy matcher.
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",
    -- Accept the selected item when the menu is open, otherwise jump to the
    -- next snippet placeholder, otherwise insert a tab.
    ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
