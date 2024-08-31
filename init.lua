local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup({
  {'navarasu/onedark.nvim'},
  { 'github/copilot.vim' },
  { 'numToStr/Comment.nvim' },
  -- lsp
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'L3MON4D3/LuaSnip' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'rafamadriz/friendly-snippets' },
})

-- settings
vim.cmd("set number")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set ruler")
vim.cmd("set showcmd")
vim.cmd("set autoread")
vim.cmd("set autoindent")
vim.cmd("set shell=/bin/zsh")
vim.cmd("set splitbelow")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set mouse=a")
vim.cmd("set cursorline")
vim.cmd("set laststatus=2")
vim.cmd("set colorcolumn=80")
vim.cmd("set list")
vim.cmd("set listchars=tab:▸\\ ,eol:¬,trail:·")

-- mappings
vim.cmd("command! W w")
vim.cmd("command! Q q")
vim.cmd("command! WQ wq")
vim.cmd("command! Wq wq")
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<Esc>O', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{}', '{}<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[]', '[]<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '()', '()<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '""', '""<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "''", "''<Esc>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':m -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'J', ':m +1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'K', ':m -2<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'J', ':m\'>+<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<BS>', 'x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Up>', ':buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>k', '<C-W><Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', '<C-W><Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', '<C-W><Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>j', '<C-W><Down>', { noremap = true, silent = true })

-- commenter
require('Comment').setup()

-- lsp
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  local opts = { buffer = bufnr, remap = false, silent = true }
  vim.keymap.set("n", "`", [[:sp<CR>:lua vim.lsp.buf.definition()<CR>]], opts)
  vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
  completion = {
    autocomplete = false,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- colorscheme
vim.cmd("colorscheme onedark")
