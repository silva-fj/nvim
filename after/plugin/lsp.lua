local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Insert}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),
  ["<Tab>"] = function(fallback)
  	if cmp.visible() then
  		cmp.select_next_item()
  	else
  		fallback()
  	end
  end,
  ["<CR>"] = cmp.mapping({
  	i = cmp.mapping.confirm({ select = true }),
  	c = cmp.mapping.confirm({
  		select = false,
  	}),
  }),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

vim.diagnostic.config({
    virtual_text = true,
})

local lsp_status = {}

local g_lsp_status = require('lsp-status')

local kind_labels_mt = {
    __index = function(_, k)
        return k
    end
}

local kind_labels = {}

setmetatable(kind_labels, kind_labels_mt)

g_lsp_status.register_progress()

g_lsp_status.config({
    kind_labels = kind_labels,
    indicator_errors = "",
    indicator_warnings = "",
    indicator_info = "",
    indicator_hint = "",
    indicator_ok = '',
    status_symbol = ""
})

function lsp_status.on_attach(client, buf)
    return g_lsp_status.on_attach(client, buf)
end

function lsp_status.get_capabilities()
    return g_lsp_status.capabilities
end

lsp.on_attach(function(client, bufnr)
  print("LSP started.")
  local opts = {buffer = bufnr, remap = false}
  lsp_status.on_attach(client, bufnr)

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end)

lsp.setup()
