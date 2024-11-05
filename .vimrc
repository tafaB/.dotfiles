colorscheme dracula
hi Normal ctermbg=none
let mapleader=" "
filetype plugin indent on

set mouse=a
set number
set colorcolumn=80
set expandtab
set tabstop=2
set shiftwidth=2
set showcmd
set showmatch
set autoread
au FocusGained,BufEnter * checktime
set autoindent
set clipboard=unnamedplus
set incsearch
set hlsearch
set wildmenu
set list
set listchars=tab:▸\ ,eol:¬,trail:·

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
nnoremap K :m -2<CR>
nnoremap J :m +1<CR>
xnoremap K :m -2<CR>gv=gv
xnoremap J :m '>+<CR>gv=gv
nnoremap <Leader>k <C-W><Up>
nnoremap <Leader>l <C-W><Right>
nnoremap <Leader>h <C-W><Left>
nnoremap <Leader>j <C-W><Down>

nnoremap <leader>f :call SelectFileFromList(0)<CR>
nnoremap <leader>1 :call SelectFileFromList(1)<CR>
nnoremap <leader>2 :call SelectFileFromList(2)<CR>
nnoremap <leader>3 :call SelectFileFromList(3)<CR>
nnoremap <leader>4 :call SelectFileFromList(4)<CR>
nnoremap <leader>a :call AddFileToList()<CR>
nnoremap <leader>l :execute 'sp ' . g:bookmarkFile<CR>
nnoremap <leader>g :call DirectoryToFileName()<CR>


function! DirectoryToFileName()
  let dir = expand('%:p:h')
  let dir = substitute(dir, '/', '-', 'g')
  let dir = 'bookmark' . dir
  return expand('~/.vim/bookmarks/' . dir)
endfunction

let g:bookmarkFile = DirectoryToFileName()

function! AddFileToList()
    let file = expand('%:p')
    let line = line('.')
    if file != ""
        call writefile([file . ' ' . line], expand(g:bookmarkFile), 'a')
        echo "Added to " . g:bookmarkFile
    else
        echo "No file to add!"
    endif
endfunction

function! SelectFileFromList(n)
    if filereadable(expand(g:bookmarkFile))
        let files = readfile(expand(g:bookmarkFile))
        if empty(files)
            echo "File list is empty!"
            return
        endif
        if a:n > 0
            if a:n <= len(files)
                let fileAndLine = split(files[a:n - 1])
                execute 'edit ' . fileAndLine[0]
                execute 'normal! ' . fileAndLine[1] . 'G'
            else
                echo "Invalid file number!"
            endif
        else
            let choice = inputlist(['Choose a file:'] + files)
            if choice > 0 && choice <= len(files)
                let fileAndLine = split(files[choice - 1])
                execute 'edit ' . fileAndLine[0]
                execute 'normal! ' . fileAndLine[1] . 'G'
            else
                echo "\nInvalid choice!"
            endif
        endif
    else
        echo "No file list found!"
    endif
endfunction
