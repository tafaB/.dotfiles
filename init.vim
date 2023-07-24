" PLUGINS "
call plug#begin('~/.config/nvim/plugged')
" colors "
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP Support
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'L3MON4D3/LuaSnip'     " Required

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
" telescope "
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
"theme"
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rose-pine/neovim'
Plug 'ishan9299/nvim-solarized-lua'

"icons"
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
"commenter"
Plug 'numToStr/Comment.nvim'
call plug#end()

" SETTINGS "
let mapleader = " "
set termguicolors
set mouse=a
set number relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set showcmd
set autoread
set shell=/bin/zsh
set laststatus=2
set splitbelow
set clipboard=unnamed
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" MAPPINGS "
command! W w
command! Q q
command! WQ wq
command! Wq wq
inoremap {<CR> {<CR>}<Esc>O
inoremap {} {}<Esc>i
inoremap [] []<Esc>i
inoremap () ()<Esc>i
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
nnoremap tt :sp<CR>:term<CR>
nnoremap <TAB> <C-w><C-w>
nnoremap fr :%s/
vnoremap fr :s/
nnoremap fa *
nnoremap  § :vsp<CR>:lua vim.lsp.buf.definition()<CR>
nnoremap  gh :lua vim.lsp.buf.hover()<CR>
" au FileType cpp  nnoremap  ` :!sh run.sh<CR>
" au FileType rust nnoremap  ` :!rustc code.rs && ./code<file.in<CR>
nnoremap ff =G
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
vnoremap K :m -2<CR>gv=gv
vnoremap J :m'>+<CR>gv=gv
vnoremap <BS> x
map - $

nnoremap <leader>+ :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>l :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>5 :lua require("harpoon.ui").nav_file(5)<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" disable the arrow keys "
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" COLORING "
lua << END
-- nvim treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "python", "rust" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }, 
}
-- lsp
local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
local cmp = require('cmp')
cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
})
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = {
    ['<TAB>'] = cmp.mapping.confirm({select = false}),
  }
})
-- colorschemes
require('rose-pine').setup{
	disable_background = true,
	disable_float_background = true,
	highlight_groups = {
	}
}
--statusline
local lualine = require('lualine')
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    component_separators = '|',
    section_separators = '|',
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  '%F',
  cond = conditions.buffer_not_empty,
}

ins_left { 'location' }

ins_left {
  function()
    return '%='
  end,
}

ins_left {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = 'LSP:',
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
}

ins_right {
  'branch',
}

ins_right {
  'diff',
  symbols = { added = '+ ', modified = '~ ', removed = '- ' },
  cond = conditions.hide_in_width,
}
lualine.setup(config)
--commenter
require('Comment').setup()
END

" THEME ~ rose-pine "
syntax on
set background=dark
colorscheme rose-pine
