" PLUGINS "
call plug#begin('~/.config/nvim/plugged')
" colors "
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ntk148v/komau.vim' " Vim-plug
" LSP Support
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'L3MON4D3/LuaSnip'     " Required
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
" telescope "
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
"icons"
Plug 'nvim-tree/nvim-web-devicons'
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
nnoremap tt :sp<CR>:term<CR>i
nnoremap <TAB> <C-w><C-w>
nnoremap fr :%s/
vnoremap fr :s/
nnoremap fa *
nnoremap  § :vsp<CR>:lua vim.lsp.buf.definition()<CR>
nnoremap  gh :lua vim.lsp.buf.hover()<CR>
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
--statusline
local function lsp()
local count = {}
local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
}
for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end
    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""
    if count["errors"] >= 0 then
        errors = " E:" .. count["errors"]
    end
    if count["warnings"] >= 0 then
        warnings = " W:" .. count["warnings"]
    end
    if count["hints"] >= 0 then
        hints = " H:" .. count["hints"]
    end
    if count["info"] >= 0 then
        info = " I:" .. count["info"]
    end
    return errors .. warnings .. hints .. info .. " "
end
local function get_lsp_server_name()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return " (NULL) "
    else
        return " (" .. clients[1].name .. ") "
    end
end
local function git_info()
    local branch = "NULL"
    if vim.fn.isdirectory('.git') ~= 0 then
        branch = vim.fn.system("git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo 'NULL'")
        branch = string.gsub(branch, "\n", "") -- Remove newline character from the result
    end
    return "    Git:" .. branch
end
local function lineinfo()
    return " %F %#StatusLine#   %p%% %l,%c "
end
Statusline = {}
Statusline.active = function()
return table.concat {
    lsp(),
    lineinfo(),
    get_lsp_server_name(),
    git_info(),
}
end
function Statusline.inactive()
    return " %F"
end
vim.api.nvim_exec([[
    augroup Statusline
        au!
        au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
        au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
    augroup END
]], false)
--commenter
require('Comment').setup()
END

syntax on
set background=light
" colorscheme
colorscheme komau
hi StatusLine guibg=black guifg=white
hi Normal guibg=none
hi NormalFloat guibg=none
