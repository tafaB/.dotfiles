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
Plug 'rose-pine/neovim'
"icons"
Plug 'nvim-tree/nvim-web-devicons'
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
au FileType cpp  nnoremap  ` :!sh run.sh<CR>
au FileType rust nnoremap  ` :!rustc code.rs && ./code<file.in<CR>
nnoremap ff =G
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
vnoremap K :m -2<CR>gv=gv
vnoremap J :m'>+<CR>gv=gv
vnoremap <BS> x
map - $

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
-- status line
END

" COMMENTS "
au FileType cpp map \; :s/^/\/\/<CR>/§<CR>
au FileType cpp map \' :s/^\/\//<CR>
au FileType c map \; :s/^/\/\/<CR>/§<CR>
au FileType c map \' :s/^\/\//<CR>
au FileType rust map \; :s/^/\/\/<CR>/§<CR>
au FileType rust map \' :s/^\/\//<CR>
au FileType python map \; :s/^/#<CR>/§<CR>
au FileType python map \' :s/^#/<CR>
au FileType vim map \; :s/^/"<CR>/§<CR>
au FileType vim map \' :s/^"/<CR>

" THEME ~ zellner "
syntax on
set background=dark
colorscheme rose-pine
hi Normal guibg=none
hi CursorLine guibg=none

" status line "
set statusline+=\ %F\ %M\ %R
set statusline+=%=
set statusline+=\ [\ %l\ :\ %c\ ]
set statusline+=\ Lines:\ %L\ 
