" PLUGINS "
call plug#begin('~/.config/nvim/plugged')
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
-- lsp
local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)
lsp.set_server_config({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
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

" Vim color file

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="desert256"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
    " functions {{{
    " returns an approximate grey index for the given grey level
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual grey level represented by the grey index
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun

    " returns the palette index for the given grey index
    fun <SID>grey_color(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun

    " returns an approximate color index for the given color level
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual color level for the given color index
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun

    " returns the palette index for the given R/G/B color indices
    fun <SID>rgb_color(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " returns the palette index to approximate the given R/G/B color levels
    fun <SID>color(r, g, b)
        " get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " get the closest color
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " there are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " use the grey
                return <SID>grey_color(l:gx)
            else
                " use the color
                return <SID>rgb_color(l:x, l:y, l:z)
            endif
        else
            " only one possibility
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    endfun

    " returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>color(l:r, l:g, l:b)
    endfun

    " sets the highlighting for the given group
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}

    call <SID>X("Normal", "cccccc", "000000", "")

    " highlight groups
    call <SID>X("Conceal", "cccccc","333333","bold")
    call <SID>X("Cursor", "708090", "f0e68c", "")
    call <SID>X("CursorLine", "", "222222", "none")
    "CursorIM
    "Directory
    call <SID>X("DiffAdd", "ffffff", "42bb42", "bold")
    call <SID>X("DiffChange", "ffffff", "6969ce", "bold")
    call <SID>X("DiffText", "ffffff", "cc4949", "bold")
    call <SID>X("DiffDelete", "ffffff", "cc4949", "bold")
    "ErrorMsg
    call <SID>X("VertSplit", "444444", "7f7f7f", "reverse")
    call <SID>X("Folded", "ffd700", "4d4d4d", "")
    call <SID>X("FoldColumn", "d2b48c", "4d4d4d", "")
    call <SID>X("IncSearch", "708090", "f0e68c", "")
    call <SID>X("LineNr", "dddddd", "111111", "")
    call <SID>X("SignColumn", "", "000000", "")
    call <SID>X("ModeMsg", "daa520", "", "")
    call <SID>X("MoreMsg", "2e8b57", "", "")
    call <SID>X("NonText", "addbe7", "000000", "bold")
    call <SID>X("Question", "00ff7f", "", "")
    call <SID>X("Search", "000000", "cd853f", "bold")
    call <SID>X("SpecialKey", "9acd32", "", "")
    call <SID>X("StatusLine", "444444", "bbbbbb", "reverse")
    call <SID>X("StatusLineNC", "444444", "222222", "reverse")
    call <SID>X("Title", "cd5c5c", "", "")
    call <SID>X("Visual", "6b8e23", "f0e68c", "reverse")
    "VisualNOS
    call <SID>X("WarningMsg", "fa8072", "", "")
    "WildMenu
    "Menu
    "Scrollbar
    "Tooltip
    call <SID>X("Pmenu", "cccccc", "333333", "")
    call <SID>X("PmenuSel", "ffffff", "444444", "")
    call <SID>X("PmenuSbar", "cccccc", "333333", "")
    call <SID>X("PmenuThumb", "bb4444", "666666", "")

    "Invisible character colors
    call <SID>X("NonText", "555555", "", "none")
    call <SID>X("SpecialKey", "555555", "", "none")

    " syntax highlighting groups
    call <SID>X("Comment", "87ceeb", "", "")
    call <SID>X("Constant", "ffa0a0", "", "")
    call <SID>X("Identifier", "98fb98", "", "none")
    call <SID>X("Statement", "f0e68c", "", "bold")
    call <SID>X("PreProc", "cd5c5c", "", "")


    call <SID>X("Type", "bdb76b", "", "bold")
    call <SID>X("Special", "ffdead", "", "")
    "Underlined
    call <SID>X("Ignore", "666666", "", "")
    "Error
    call <SID>X("Todo", "ff4500", "eeee00", "")
    call <SID>X("SpellBad", "ff6666", "000000", "bold")
    call <SID>X("SpellCap", "ffff66", "000000", "bold")

    call <SID>X("User1", "eea040", "444444", "")
    call <SID>X("User2", "dd3333", "444444", "")
    call <SID>X("User3", "ff66ff", "444444", "")
    call <SID>X("User4", "a0ee40", "444444", "")
    call <SID>X("User5", "eeee40", "444444", "")

    call <SID>X("GitGutterAdd", "00ff00", "", "")
    call <SID>X("GitGutterChange", "ffff00", "", "")
    call <SID>X("GitGutterDelete", "ff0000", "", "")
    call <SID>X("GitGutterChangeDelete", "ffff00", "", "")

    " delete functions {{{
    delf <SID>X
    delf <SID>rgb
    delf <SID>color
    delf <SID>rgb_color
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_color
    delf <SID>grey_level
    delf <SID>grey_number
    " }}}
else
    " color terminal definitions
    hi Directory     ctermfg=darkcyan
    hi ErrorMsg      cterm=bold ctermfg=7 ctermbg=1
    hi IncSearch     cterm=NONE ctermfg=yellow ctermbg=green
    hi Search        cterm=NONE ctermfg=grey ctermbg=blue
    hi MoreMsg       ctermfg=darkgreen
    hi ModeMsg       cterm=NONE ctermfg=brown
    hi LineNr        ctermfg=3
    hi Question      ctermfg=green
    hi StatusLine    cterm=bold,reverse
    hi StatusLineNC  cterm=reverse
    hi VertSplit     cterm=reverse
    hi Title         ctermfg=5
    hi Visual        cterm=reverse
    hi VisualNOS     cterm=bold,underline
    hi WarningMsg    ctermfg=1
    hi WildMenu      ctermfg=0 ctermbg=3
    hi Folded        ctermfg=darkgrey ctermbg=NONE
    hi FoldColumn    ctermfg=darkgrey ctermbg=NONE
    hi DiffAdd       ctermbg=4
    hi DiffChange    ctermbg=5
    hi DiffDelete    cterm=bold ctermfg=4 ctermbg=6
    hi DiffText      cterm=bold ctermbg=1
    hi Comment       ctermfg=darkcyan
    hi Constant      ctermfg=brown
    hi Special       ctermfg=5
    hi Identifier    ctermfg=6
    hi Statement     ctermfg=3
    hi PreProc       ctermfg=5
    hi Type          ctermfg=2
    hi Underlined    cterm=underline ctermfg=5
    hi Ignore        ctermfg=darkgrey
    hi Error         cterm=bold ctermfg=black ctermbg=1
endif

" vim: set fdl=0 fdm=marker:
