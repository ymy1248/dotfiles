if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

endif

call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'edkolev/tmuxline.vim'
Plug 'preservim/tagbar'
Plug 'mhinz/vim-signify'
Plug 'skywind3000/asyncrun.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'maralla/completor.vim'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim'] }
Plug 'sgur/vim-textobj-parameter'

call plug#end()

set tags=./.tags;,.tags
set backspace=2
" set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set expandtab
set number
set background=dark
set t_Co=256
set cursorline
set scrolloff=4
set hlsearch
set completeopt=longest,menuone
set splitright
set colorcolumn=101
set relativenumber
set updatetime=300

"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

colorscheme gruvbox

let g:airline_theme='gruvbox'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
let NERDTreeShowHidden=1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:airline#extensions#tabline#enabled = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

let g:ale_completion_enabled = 0

"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>r :NERDTreeFind<cr>
nnoremap <silent> <leader>c :SignifyDiff<CR>
nnoremap <silent> <leader>b :TagbarToggle<CR>
nnoremap <silent> <leader>u :SignifyHunkUndo<CR>
nnoremap <silent> <leader>t :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <leader>f :Tags<CR>
nnoremap <silent> <leader>g :call LanguageClient#textDocument_references()<CR>

nnoremap <silent> [e :ALEPrevious<CR>
nnoremap <silent> ]e :ALENext<CR>
nnoremap <silent> [c  :execute "normal \<Plug>(signify-prev-hunk)" \| SignifyHunkDiff<CR>
nnoremap <silent> ]c  :execute "normal \<Plug>(signify-next-hunk)" \| SignifyHunkDiff<CR>

nnoremap <left> :tabprev<CR>
nnoremap <right> :tabnext<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>

autocmd FileType qf wincmd J

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <leader><CR> :call ToggleQuickFix()<cr>

autocmd TextChanged,InsertLeave * if &readonly == 0 && filereadable(bufname('%')) | silent write | endif

function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
  " If we aren't typing a word and we press `tab` simply do the n
  return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:completor_auto_trigger = 1
" inoremap <expr> <Tab> Tab_Or_Complete()

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

let g:gutentags_ctags_tagfile = '.tags'

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_echoProjectRoot = 1
let g:LanguageClient_rootMarkers = ['.root', '.svn', '.git', '.hg', '.project', 'compile_commands.json']
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'h': ['clangd'],
    \ 'cc': ['clangd'],
    \ 'hh': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'hpp': ['clangd'],
    \ }

let g:completor_filetype_map = {}
let g:completor_filetype_map.h = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.hh = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.hpp = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.c = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.cc = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_filetype_map.cpp = {'ft': 'lsp', 'cmd': 'clangd'}
let g:completor_blacklist = ['tagbar', 'qf', 'netrw', 'unite', 'vimwiki', 'lsp-quickpick', 'lsp-quickpick-filter']
