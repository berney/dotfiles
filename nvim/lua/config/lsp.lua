local M = {}

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Server settings layered on top of nvim-lspconfig's lsp/*.lua defaults.
vim.lsp.config("jsonls", {
  settings = {
    json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
  },
})
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = "" },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
    },
  },
})
-- lspconfig derives storagePath from the cwd when the config is first loaded;
-- outside a Gradle/Maven project that leaves init_options empty, which is sent
-- as a JSON array and makes the server fail to initialise.
vim.lsp.config("kotlin_language_server", {
  init_options = { storagePath = vim.fn.stdpath("cache") .. "/kotlin-language-server" },
})
-- Defined but not enabled; turn on with :lua vim.lsp.enable("semgrep")
vim.lsp.config("semgrep", {
  cmd = { "semgrep", "lsp" },
  filetypes = { "python", "javascript", "typescript", "go", "java", "json", "yaml", "dockerfile" },
  root_markers = { ".semgrep.yml", ".semgrep", ".git" },
})

vim.lsp.enable({
  "ts_ls",
  "eslint",
  "pyright",
  "ruff",
  "jsonls",
  "yamlls",
  "lua_ls",
  "vimls",
  "gopls",
  "terraformls",
  "solargraph",
  "kotlin_language_server",
  "graphql",
  "bashls",
  "taplo",
})

-- Operator for <Leader>f in normal mode: <Leader>fip formats a paragraph.
function M.format_operator()
  local start = vim.api.nvim_buf_get_mark(0, "[")
  local finish = vim.api.nvim_buf_get_mark(0, "]")
  require("conform").format({ range = { start = start, ["end"] = finish } })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("berney-lsp", { clear = true }),
  callback = function(ev)
    local buf = ev.buf
    local function map(mode, lhs, rhs, desc, opts)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = buf, desc = desc }, opts or {}))
    end

    map("n", "gd", vim.lsp.buf.definition, "Definition")
    map("n", "gy", vim.lsp.buf.type_definition, "Type definition")
    map("n", "gi", vim.lsp.buf.implementation, "Implementation")
    -- nowait: don't pause for Neovim's global gr* defaults (grn, grr, ...).
    map("n", "gr", vim.lsp.buf.references, "References", { nowait = true })
    map("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
    map("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
    map("n", "<Leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<Leader>f", function()
      vim.o.operatorfunc = "v:lua.require'config.lsp'.format_operator"
      return "g@"
    end, "Format motion", { expr = true })
    map("x", "<Leader>f", function() require("conform").format() end, "Format selection")
    map({ "n", "x" }, "<Leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<Leader>cA", function()
      vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
    end, "Source action (buffer)")
    map("n", "<Leader>qf", function()
      vim.lsp.buf.code_action({ context = { only = { "quickfix" } }, apply = true })
    end, "Quick fix")

    -- Highlight references of the symbol under the cursor while idle.
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", buf) then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = vim.api.nvim_create_augroup("berney-lsp-highlight-" .. buf, { clear = true }),
        buffer = buf,
        callback = function()
          if #vim.lsp.get_clients({ bufnr = buf, method = "textDocument/documentHighlight" }) > 0 then
            vim.lsp.buf.document_highlight()
          end
        end,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = "berney-lsp-highlight-" .. buf,
        buffer = buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_create_user_command("Format", function()
  require("conform").format()
end, { desc = "Format buffer" })
vim.api.nvim_create_user_command("OR", function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} }, apply = true })
end, { desc = "Organize imports" })

return M
