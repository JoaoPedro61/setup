set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim Installer Plugs with Vundle""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'rust-lang/rust.vim'

Plugin 'nathanaelkane/vim-indent-guides'

Plugin 'leafgarland/typescript-vim'

Plugin 'neoclide/coc.nvim'
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-rls']

Plugin 'shougo/vimproc.vim'

Plugin 'quramy/tsuquyomi'

Plugin 'scrooloose/nerdtree'

Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'kien/rainbow_parentheses.vim'

Plugin 'ayu-theme/ayu-vim'

Plugin 'morhetz/gruvbox'

Plugin 'scrooloose/syntastic'

Plugin 'Lokaltog/powerline'

Plugin 'mxw/vim-jsx'

Plugin 'maxmellon/vim-jsx-pretty'

call vundle#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



"""""""""""" Start Powerline Settings """"""""""""""""

set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Source\ Code\ Pro\ for\ Powerline:h15
        colorscheme PaperColor              " set color scheme
    endif
endif




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim Installer Plugs with Plug""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim Identguide configs"""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim NERDTree configs"""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim Typescript configs"""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim COC Configs""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_user_config = {}

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

command! -nargs=0 Format :call     CocAction('format')

command! -nargs=0 OR     :call     CocAction('runCommand', 'editor.action.organizeImport')

command! -nargs=? Fold   :call     CocAction('fold', <f-args>)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User
augroup end

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim Airline Configs!!""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim Theme Ayu Configs""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Rainbow Configs""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Buffers Nav""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
nmap <leader>[l  :<C-u>ls<cr>
nmap <leader>Q  :<C-u>bd<cr>
nmap <leader>[-  :<C-u>bprev<cr>
nmap <leader>[+  :<C-u>bnext<cr>
nmap <leader>[sn  :<C-u>sbn<cr>
nmap <leader>[sp  :<C-u>sbp<cr>
nmap <leader>[sa  :<C-u>sba<cr>

" Tabs Nav Split
nmap <leader>[s1  :<C-u>sb 1<cr>
nmap <leader>[s2  :<C-u>sb 2<cr>
nmap <leader>[s3  :<C-u>sb 3<cr>
nmap <leader>[s4  :<C-u>sb 4<cr>
nmap <leader>[s5  :<C-u>sb 5<cr>
nmap <leader>[s6  :<C-u>sb 6<cr>
nmap <leader>[s7  :<C-u>sb 7<cr>
nmap <leader>[s8  :<C-u>sb 8<cr>
nmap <leader>[s9  :<C-u>sb 9<cr>
nmap <leader>[s0  :<C-u>sb 10<cr>

" Tabs Nav
nmap <leader>[1  :<C-u>b1<cr>
nmap <leader>[2  :<C-u>b2<cr>
nmap <leader>[3  :<C-u>b3<cr>
nmap <leader>[4  :<C-u>b4<cr>
nmap <leader>[5  :<C-u>b5<cr>
nmap <leader>[6  :<C-u>b6<cr>
nmap <leader>[7  :<C-u>b7<cr>
nmap <leader>[8  :<C-u>b8<cr>
nmap <leader>[9  :<C-u>b9<cr>
nmap <leader>[0  :<C-u>b10<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""Vim sets"""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set number
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set clipboard=unnamed


au BufNewFile,BufRead *.ts setlocal filetype=typescript

au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
