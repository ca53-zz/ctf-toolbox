call plug#begin('~/.local/share/nvim/plugged')

Plug 'takac/vim-hardtime'
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'pbogut/fzf-mru.vim'

call plug#end()


"""""""""""""""""""""""""""""InitialSettings"""""""""""""""""""""""""""""""""""

" basics
set encoding=utf-8

" Enable mouse
set mouse=a

" Line numbering
set number
set relativenumber

" Dafault split
set splitright
set splitbelow

syntax on

set termguicolors
set background=dark
colorscheme gruvbox
"hi Normal ctermbg=NONE guibg=NONE

" Tab spaces and text width
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=120
set colorcolumn=120
set noexpandtab

set updatetime=250

" Allow to load buffers in a window, which currently has a buffer with unused
" modifications
set hidden

" convert tab to spaces
set expandtab

" Leave insert mode in terminal
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+t
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-t> :call OpenTerminal()<CR>

" Leave insert mode
inoremap jj <ESC>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"""""""""""""""""""""""""""""HardTime""""""""""""""""""""""""""""""""""""""""""
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 4

"""""""""""""""""""""""""""""Airline"""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"""""""""""""""""""""""""""""COC""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \'coc-java',
  \'coc-json',
  \'coc-tsserver',
  \'coc-python',
  \'coc-json',
  \'coc-html',
  \'coc-yaml'
  \]
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"""""""""""""""""""""""""""""NERDTree""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""IndentLine""""""""""""""""""""""""""""""""""""""""
let g:indentLine_color_gui = '#665c54'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = ['nerdtree']

"""""""""""""""""""""""""""""Gruvebox""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"

"""""""""""""""""""""""""""""""FZF"""""""""""""""""""""""""""""""""""""""""""""
" Escape inside a FZF terminal window should exit the terminal window
" rather than going into the terminal's normal mode.
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>h :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>g :GFiles?<CR>
nnoremap <silent> <Leader>]  :Tags<CR>
nnoremap <silent> <Leader>b] :BTags<CR>
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <Leader>c  :Commits<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>
nnoremap <Leader>rg :Rg<Space>
nnoremap <Leader>RG :Rg!<Space>
nnoremap <silent> <Leader>m :FZFMru<CR>
