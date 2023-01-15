" PLUGINS "
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/neoclide/coc.nvim'
call plug#end()

" SETTINGS "
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
nnoremap  § :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap  ` :!sh run.sh<CR>
nnoremap ff =G
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
vnoremap K :m -2<CR>gv=gv
vnoremap J :m +2<CR>gv=gv
vnoremap <BS> x
map - $
inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

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
lua<<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }, 
}
EOF

" COMMENTS "
au FileType cpp vnoremap <leader>; :s/^/\/\/<CR>/§<CR>
au FileType cpp vnoremap <leader>' :s/^\/\//<CR>
au FileType c vnoremap <leader>; :s/^/\/\/<CR>/§<CR>
au FileType c vnoremap <leader>' :s/^\/\//<CR>
au FileType python vnoremap <leader>; :s/^/#<CR>/§<CR>
au FileType python vnoremap <leader>' :s/^#/<CR>

" STATUS LINE "
set statusline+=\ File:%F\ %M\ Type:%Y\ %R
set statusline+=%=
set statusline+=\ Ascii:\ %b\ Hex:\ 0x%B\ Row:\ %l\ Col:\ %c
set statusline+=\ Lines:\ %L
set fillchars=stl:-,stlnc:-

" THEME ~ zellner "
syntax enable
set background=light

hi! link Terminal Normal
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi Normal guifg=#000000 guibg=#ffffff gui=NONE cterm=NONE
hi Folded guifg=#00008b guibg=#d3d3d3 gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#ffffff gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#e5e5e5 gui=NONE cterm=NONE
hi CursorLineNr guifg=#a52a2a guibg=NONE gui=bold cterm=bold
hi QuickFixLine guifg=#ffffff guibg=#6a5acd gui=NONE cterm=NONE
hi EndOfBuffer guifg=#a9a9a9 guibg=NONE gui=NONE cterm=NONE
hi StatusLine guibg='#000000' guifg='#ffffff' gui=NONE cterm=NONE
hi StatusLineNC guibg=grey guifg='#ffffff' gui=NONE cterm=NONE
hi StatusLineTerm guifg=#ffffff guibg=#006400 gui=NONE cterm=NONE
hi StatusLineTermNC guifg=#ffffff guibg=#0000ff gui=NONE cterm=NONE
hi VertSplit guifg=#ffffff guibg=#000000 gui=NONE cterm=NONE
hi Pmenu guifg=#000000 guibg=#dadada gui=NONE cterm=NONE
hi PmenuSel guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#ffffff gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#a9a9a9 gui=NONE cterm=NONE
hi TabLine guifg=#000000 guibg=#a9a9a9 gui=underline cterm=underline
hi TabLineFill guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi TabLineSel guifg=#000000 guibg=#ffffff gui=bold cterm=bold
hi ToolbarLine guifg=NONE guibg=#d3d3d3 gui=NONE cterm=NONE
hi ToolbarButton guifg=NONE guibg=#a9a9a9 gui=bold cterm=bold
hi NonText guifg=#a9a9a9 guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#a9a9a9 guibg=NONE gui=NONE cterm=NONE
hi Visual guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi VisualNOS guifg=NONE guibg=#ff0000 gui=NONE cterm=NONE
hi LineNr guifg=#a52a2a guibg=NONE gui=NONE cterm=NONE
hi FoldColumn guifg=#00008b guibg=NONE gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Underlined guifg=#6a5acd guibg=NONE gui=underline cterm=underline
hi Error guifg=#ff0000 guibg=#ffffff gui=reverse cterm=reverse
hi ErrorMsg guifg=#ff0000 guibg=#ffffff gui=reverse cterm=reverse
hi WarningMsg guifg=#a020f0 guibg=#ffffff gui=NONE cterm=NONE
hi MoreMsg guifg=#000000 guibg=#ffffff gui=bold cterm=bold
hi ModeMsg guifg=#000000 guibg=#ffffff gui=bold cterm=bold
hi Question guifg=#ff00ff guibg=NONE gui=bold cterm=bold
hi Todo guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi MatchParen guifg=#ffffff guibg=#ff00ff gui=NONE cterm=NONE
hi Search guifg=#ffffff guibg=#a020f0 gui=NONE cterm=NONE
hi IncSearch guifg=#000000 guibg=NONE gui=reverse cterm=reverse
hi WildMenu guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#eeeeee gui=NONE cterm=NONE
hi Cursor guifg=#ffffff guibg=#000000 gui=NONE cterm=NONE
hi lCursor guifg=#000000 guibg=#ff00ff gui=NONE cterm=NONE
hi SpellBad guifg=#ff0000 guibg=NONE guisp=#ff0000 gui=undercurl cterm=underline
hi SpellCap guifg=#0000ff guibg=NONE guisp=#0000ff gui=undercurl cterm=underline
hi SpellLocal guifg=#878700 guibg=NONE guisp=#878700 gui=undercurl cterm=underline
hi SpellRare guifg=#008787 guibg=NONE guisp=#008787 gui=undercurl cterm=underline
hi Comment guifg=#ff0000 guibg=NONE gui=NONE cterm=NONE
hi Constant guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE
hi Identifier guifg=#0000ff guibg=NONE gui=NONE cterm=NONE
hi Statement guifg=#a52a2a guibg=NONE gui=NONE cterm=NONE
hi PreProc guifg=#a020f0 guibg=NONE gui=NONE cterm=NONE
hi Type guifg=#0000ff guibg=NONE gui=NONE cterm=NONE
hi Special guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE
hi Tag guifg=#006400 guibg=NONE gui=NONE cterm=NONE
hi Directory guifg=#0000ff guibg=NONE gui=bold cterm=bold
hi Conceal guifg=#ff0000 guibg=NONE gui=NONE cterm=NONE
hi Ignore guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Title guifg=#a020f0 guibg=NONE gui=bold cterm=bold
hi DiffAdd guifg=#ffffff guibg=#5f875f gui=NONE cterm=NONE
hi DiffChange guifg=#ffffff guibg=#5f87af gui=NONE cterm=NONE
hi DiffText guifg=#000000 guibg=#c6c6c6 gui=NONE cterm=NONE
hi DiffDelete guifg=#ffffff guibg=#af5faf gui=NONE cterm=NONE
