execute pathogen#infect('bundle/{}', '~/.vim/bundle/powerline/powerline/bindings/{}')
execute pathogen#helptags()

syntax on
filetype plugin indent on

" Configuration file for vim
set modelines=0  " CVE-2007-2438

" Ignore non-editable files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/CACHE/*

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible  " Use Vim defaults instead of 100% vi compatibility
set backspace=2  " more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup
" Remove trailing white space on save
au FileType *.js,*.jsx,*.py,*.html,*.css,*.less,*.rb,*.coffee,*.erb,*.hbs autocmd BufWritePre <buffer> :%s/\s\+$//e

set t_Co=256
" set spell "activates vim spellchecker
set clipboard=unnamed "required to use the clipboard
set tabstop=2 "number of spaces that will be inserted when tab key is pressed
set shiftwidth=2 "number of spaces that will be inserted for indentation
set expandtab "insert space characters whenever tab is pressed
set autochdir "auto change into working directory
set ruler "ruler on
set ignorecase "ignore cases
set scs "smart search on
set autoindent "auto indentation
set laststatus=2 "always display a status at the bottom of the window
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set shortmess=a "set Vim to use short messages
set hlsearch "highlight searches
set nu "line number
set incsearch "do incremental search
set showmode "indicates input or replace mode at the bottom
set splitright "split the new file on the right
set splitbelow "split the new file below
set mouse=a " enable mouse

set backup "keep a backup file
set backupdir=/tmp "backup dir
set directory=/tmp "swap file dir
colorscheme Tomorrow-Night "set colorscheme

"airbnb
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
au BufWinEnter,BufNewFile * silent tab
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set textwidth=100
set colorcolumn=101
au BufEnter * set colorcolumn=101
set encoding=utf-8

"runs flake8 every time you save a *.py file
"autocmd BufWritePost,FileWritePost *.py call Flake8()

"if has("autocmd")
  "autocmd bufwritepost .vimrc source $MYVIMRC
"endif

"open NERDtree when vim starts up without any specified files
autocmd vimenter * if !argc() | NERDTree | endif
"close vim if the only window left open is NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"NERDTree settings
let g:NERDTreeWinPos = "right"

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': ['javascript', 'coffeescript', 'ruby'],
  \ }

"let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint']

"vim-latex settings
let g:tex_flavor='latex'
let g:Tex_ViewRuleComplete_pdf = '/usr/bin/open -a Preview $*.pdf'
let Tex_FoldedSections=""
let Tex_FoldedEnvironments=""
let Tex_FoldedMisc=""

"pbcopy shortcuts
map <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

"region expanding
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"discover text search object
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

"format json
nmap =j :%!python -m json.tool<CR>

"shortcuts
let mapleader = "\<Space>"
set pastetoggle=<F3> "enable paste mode toggle with "f3"
let g:BASH_Ctrl_j = 'off' "turn off Ctrl + j
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>p :let g:ctrlp_directory=getcwd() <bar> execute ':CtrlP' . ctrlp_directory<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>ab :NERDTree ~/Airbnb/<CR>
nnoremap <leader>gs :NERDTree ~/Projects/whogotstyle/<CR>
nnoremap <leader>a :call CmdLine("ProjectRootExe Ack! ")<CR>
nnoremap <leader>va :let g:virtualenv_directory=ProjectRootGuess() <bar> VirtualEnvActivate venv<CR>
nnoremap <leader>vd :VirtualEnvDeactivate<CR>
nnoremap <leader>s :SyntasticCheck<CR>
nnoremap <silent> <C-n> :noh<CR>
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nmap <Leader><Leader> V

"JAVA settings
autocmd Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

nnoremap <leader>jc :make<Return>:copen<Return>
nnoremap <leader>jr :!java -cp %:p:h %:t:r<Return>

"code folding
set foldmethod=indent
set foldlevel=99

"ctrlp settings
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/](node_modules|vendor|venv|CACHE|cache|tmp|log)|(\.(git|hg|svn))$',
	\ 'file': '\v\.(exe|so|dll|mp3|mp4|avi|jpg|jpeg|gif|png|pyc|eot|svg|ttf|woff|zip|docx|doc|pdf)$',
	\ }
let g:ctrlp_lazy_update = 100 "Only refreshes the results every 100ms so if you type fast searches don't pile up
let g:ctrlp_user_command = 'find %s -type f | egrep -iv "(\.(eot|gif|gz|ico|jpg|jpeg|otf|png|psd|pyc|svg|ttf|woff|zip)$)|(/\.)|((^|\/)tmp\/)"' "Quicker indexing

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

"jedi-vim settings
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "right"

"Powerline settings
let g:Powerline_symbols = 'fancy'

"css-syntax highlighting fix
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

"Ack settings
let g:ackhighlight = 1

"vim-jsx settings
let g:jsx_ext_required = 0

"Multiple Cursors settings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-N>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"Visual Mode Mapping
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> <leader>a :call VisualSelection('ack')<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'ack'
        call CmdLine("ProjectRootExe Ack! " . l:pattern)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Make arrow keys resize windows
nnoremap <right> :vertical resize +5<cr>
nnoremap <left> :vertical resize -5<cr>
nnoremap <up> :resize +5<cr>
nnoremap <down> :resize -5<cr>

"Ignore white spaces for git diffs
set diffopt+=iwhite

"Make Fugitive compatible with Github Enterprise
let g:fugitive_github_domains = ['github.com', 'git.airbnb.com']
