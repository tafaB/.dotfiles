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
  {'catppuccin/nvim' },
  { 'github/copilot.vim' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'ThePrimeagen/harpoon' },
  { 'numToStr/Comment.nvim' },
  { 'tpope/vim-fugitive' },
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
vim.cmd("set mouse=a")
vim.cmd("set number")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set expandtab")
vim.cmd("set ruler")
vim.cmd("set showcmd")
vim.cmd("set autoread")
vim.cmd("set shell=/bin/zsh")
vim.cmd("set splitbelow")
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set cursorline")
vim.cmd("set laststatus=2")
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
vim.api.nvim_set_keymap('n', '<F12>', ':vsp<CR>:e .<CR>', { noremap = true, silent = true })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>+", mark.add_file)
vim.keymap.set("n", "<leader>l", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)

-- treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "rust" },
  auto_install = true,
  highlight = {
    enable = true,
  },
}

-- commenter
require('Comment').setup()

-- lsp
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false, silent = true }
  vim.keymap.set("n", "`", [[:vsp<CR>:lua vim.lsp.buf.definition()<CR>]], opts)
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
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})

--telescope
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local function set_telescope_mapping(key, command, theme)
  vim.keymap.set('n', key, function()
    command(theme)
  end, { noremap = true, silent = true })
end
set_telescope_mapping('<leader>ff', builtin.find_files, themes.get_ivy())
set_telescope_mapping('<leader>fg', builtin.live_grep, themes.get_ivy())
set_telescope_mapping('<leader>fb', builtin.buffers, themes.get_ivy())
set_telescope_mapping('<leader>fh', builtin.help_tags, themes.get_ivy())

-- colors
require("catppuccin").setup({
	transparent_background = true,
})
vim.cmd.colorscheme "catppuccin"
vim.cmd("hi StatusLine guibg=#2a2b3c guifg=#cdd6f4")
