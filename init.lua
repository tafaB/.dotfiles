local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup({
  { 'nvim-treesitter/nvim-treesitter' },
  { 'numToStr/Comment.nvim' },
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

vim.cmd.colorscheme("base16")

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
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set mouse=a")
vim.cmd("set cursorline")
vim.cmd("set laststatus=2")
vim.cmd("set colorcolumn=80")
vim.cmd("set path+=**")
vim.cmd("set list")
vim.cmd("set listchars=tab:▸\\ ,eol:¬,trail:·")

vim.cmd("command! W w")
vim.cmd("command! Q q")
vim.cmd("command! WQ wq")
vim.cmd("command! Wq wq")

vim.cmd("let g:netrw_banner=0")
vim.cmd("let g:netrw_browse_split=3")
vim.cmd("let g:netrw_altv=1")
vim.cmd("let g:netrw_liststyle=3")

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap('i', '{<CR>', '{<CR>}<Esc>O', opts);
keymap('i', '{}', '{}<Esc>i', opts);
keymap('i', '[]', '[]<Esc>i', opts);
keymap('i', '()', '()<Esc>i', opts);
keymap('i', '""', '""<Esc>i', opts);
keymap('i', "''", "''<Esc>i", opts);
keymap('n', 'K', ':m -2<CR>', opts);
keymap('n', 'J', ':m +1<CR>', opts);
keymap('x', 'K', ':m -2<CR>gv=gv', opts);
keymap('x', 'J', ':m\'>+<CR>gv=gv', opts);
keymap('n', '<Leader>k', '<C-W><Up>', opts);
keymap('n', '<Leader>l', '<C-W><Right>', opts);
keymap('n', '<Leader>h', '<C-W><Left>', opts);
keymap('n', '<Leader>j', '<C-W><Down>', opts);
keymap('n', '<Leader>t', ':tabnew %<CR>', opts);
keymap('n', '<Leader>1', '1gt', opts);
keymap('n', '<Leader>2', '2gt', opts);
keymap('n', '<Leader>3', '3gt', opts);
keymap('n', '<Leader>4', '4gt', opts);

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  opts = { buffer = bufnr, remap = false, silent = true }
  vim.keymap.set("n", "g<", [[:sp<CR>:lua vim.lsp.buf.definition()<CR>]], opts)
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
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

require('Comment').setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "kotlin", "rust"},
  auto_install = true,
  highlight = {
    enable = true,
  }
}
