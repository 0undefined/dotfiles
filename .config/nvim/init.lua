#!/usr/bin/env lua

function path_join(...)
  return table.concat(vim.tbl_flatten { ... }, '/')
end

-- Source the VIMRC before doing any neovim lua stuffs
local vimrcpath = path_join { vim.api.nvim_eval [[stdpath('config')]], 'vimrc' }

vim.cmd {cmd='source', args={vimrcpath}}


-- Lsp servers
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {filetypes = {'c', 'cc', 'cpp', 'h', 'hpp', 'cxx'}}
lspconfig.futhark_lsp.setup {}
lspconfig.rust_analyzer.setup {}

-- Lsp options
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- enable omnifunc
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- buffer-local mappings
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set('i', '<C-Space>', vim.lsp.omnifunc, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end,
})
