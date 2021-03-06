" use vim instead of vi stuff
set nocompatible

" backspace is always being flaky
set backspace=indent,eol,start

" misc
set encoding=utf-8

" line numbers
set number

" gimme spaces please
set tabstop=2
set shiftwidth=2
set softtabstop=2
set numberwidth=4
set expandtab

" just stop please
set nobackup
set nowritebackup
set history=10000
set hidden

" copy and paste
set clipboard=unnamed

" infinite undo
set undofile
set undodir=~/.vim/undo

" swap
set directory=~/.vim/swap

" better search
set hlsearch
set ignorecase
set smartcase
set showmatch
set incsearch

" ignore these
set wildignore=*/node_modules/*,*/elm-stuff/*

" bind pastemode to F2
set pastetoggle=<F2>

" status bar
set laststatus=2

" i just dont care for \
let mapleader=','

" i like cursor lines
set cursorline

" couple saner remaps
inoremap jj <Esc>
nnoremap ; :
nnoremap : ;

" sane behaviour for moving over lines
nnoremap j gj
nnoremap k gk

" buffers
nnoremap <leader>b :ls<CR>:buffer<Space>

" ctags
augroup ctags
  autocmd Filetype java set tags=$HOME/Documents/framework/.tags
  autocmd Filetype jsp set tags=$HOME/Documents/framework/.tags
augroup END

" templates
" go to line with %HERE% on it, thanks vim-template for idea
function! Here()
  0
  if search('%HERE%', 'W')
    let l = line('.')
    let c = col('.')
    s/%HERE%//ge
    call cursor(l, c)
  endif
endfunction

" group of template loads
augroup templates
  autocmd BufNewFile *.handlebars 0r ~/.vim/templates/skeleton.html | call Here()
  autocmd BufNewFile *.htm 0r ~/.vim/templates/skeleton.html | call Here()
  autocmd BufNewFile *.html 0r ~/.vim/templates/skeleton.html | call Here()
  autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py | call Here()
  autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh | call Here()
augroup END

" strip end of lines and change tabs to spaces
function! Clean()
  let _s=@/
  let l = line('.')
  let c = col('.')
  %s/\t/\ \ /ge
  %s/\s\+$//ge
  let @/=_s
  call cursor(l, c)
  set ff=unix
endfunction
nnoremap <leader>7 :call Clean()<CR>

" map W to write current buffer with superuser privileges
command W :execute ':silent w !sudo tee % >/dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % >/dev/null' | :quit!

" plugins
call plug#begin()
" Local FZF
Plug('/usr/local/opt/fzf')

" Browsing
Plug('https://github.com/scrooloose/nerdtree')

" Comments
Plug('https://github.com/tyru/caw.vim')

" Elm
Plug('https://github.com/ElmCast/elm-vim')

" Formatting
Plug('https://github.com/machakann/vim-sandwich')

" Git
Plug('https://github.com/airblade/vim-gitgutter')
Plug('https://github.com/tpope/vim-fugitive')

" Javascript
Plug('https://github.com/MaxMEllon/vim-jsx-pretty')
Plug('https://github.com/herringtondarkholme/yats.vim')
Plug('https://github.com/pangloss/vim-javascript')

" JSON
Plug('https://github.com/elzr/vim-json')

" Lightline
Plug('https://github.com/itchyny/lightline.vim')
Plug('https://github.com/maximbaz/lightline-ale')
Plug('https://github.com/mike-hearn/base16-vim-lightline')

" Linting
Plug('https://github.com/w0rp/ale')

" Logos
Plug('/Users/dylan/src/logos/extras/vim')

" Markdown
Plug('https://github.com/tpope/vim-markdown')

" Pug (Jade)
Plug('https://github.com/digitaltoad/vim-pug')

" ReasonML
Plug('https://github.com/reasonml-editor/vim-reason-plus')

" Searching
Plug('https://github.com/mileszs/ack.vim')

" Styling
Plug('https://github.com/fnune/base16-vim')

" Stylus
Plug('https://github.com/wavded/vim-stylus')

" Swift
Plug('https://github.com/keith/swift.vim')

" Undo
Plug('https://github.com/mbbill/undotree')

" Vue
Plug('https://github.com/posva/vim-vue.git')
call plug#end()

" filetypes
augroup filetypes
  au BufNewFile,BufRead *.md set filetype=markdown
  au BufNewFile,BufRead *.tsx,*.jsx set filetype=javascriptreact
  au BufNewFile,BufRead *.x,*.xm,*.xmm,*.l.mm setf logos
augroup END

" vim-indent-guides
" let g:indent_guides_enable_on_vim_startup = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" polygot
" let g:polygot_disabled = [ 'elm', 'javascript', 'json', 'jsx', 'markdown', 'reason', 'stylus', 'typescript', 'vue' ]

" FZF instead of ctrlp
nnoremap <C-p> :FZF<CR>
let g:fzf_colors= {
      \ 'fg': ['fg', 'Normal'],
      \ 'bg': ['bg', 'Normal'],
      \ 'hl': ['bg', 'IncSearch'],
      \ 'hl+': ['bg', 'IncSearch'],
      \ 'bg+': ['bg', 'Normal'],
      \ }

let g:fzf_layout = { 'down': '40%' }

" Thank you HN, easy macro use
noremap <Space> @q

" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
augroup nerd
  autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
  autocmd vimenter * wincmd p
augroup END

" undotree
nnoremap <leader>m :UndotreeToggle<CR>

" livedown
" must run `yarn global add livedown`
" nnoremap <leader>lt :LivedownToggle<CR>
" nnoremap <leader>lk :LivedownKill<CR>
" nnoremap <leader>lp :LivedownPreview<CR>
" let g:livedown_autorun = 0
" let g:livedown_open = 1
" let g:livedown_port = 3000
" let g:livedown_browser = 'firefox'

" pandoc
" let g:pandoc#spell#enabled = 0
" let g:pandoc#modules#disabled = ['folding']

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-jsx-pretty
" let g:vim_jsx_pretty_colorful_config = 1

" fugitive
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gca :Gcommit --amend<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gv :Gvdiff<CR>
nnoremap <leader>gs :Gstatus<CR>

" ALE Prettier
let g:ale_fixers = {
        \ 'javascript': [ 'eslint' ],
        \ 'typescript': [ 'eslint' ],
        \ 'javascriptreact': [ 'eslint' ],
        \ 'typescriptreact': [ 'eslint' ],
        \ 'javascript.jsx': [ 'eslint' ],
        \ 'typescript.jsx': [ 'eslint' ]
      \ }

let g:ale_fix_on_save = 0
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
nnoremap <leader>f :ALEFix<CR>
nnoremap <leader>k :ALEPreviousWrap<CR>
nnoremap <leader>j :ALENextWrap<CR>

" Use ack.vim instead of ag.vim
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev rg Ack
nnoremap <leader>a :Ack<Space>

" airline
" let g:airline_theme = 'base16'
" let g:airline_powerline_fonts = 0

" lightline
let g:lightline = {
        \ 'colorscheme': 'base16_dracula',
        \ 'active': {
          \ 'left': [
            \ [ 'mode', 'paste' ],
            \ [ 'readonly', 'filename', 'mod' ]
          \ ],
          \ 'right': [
            \ [ 'linter_ok', 'linter_checking', 'linter_errors', 'linter_warnings', 'lineinfo' ],
            \ [ 'fileinfo' ]
          \ ]
        \ },
        \ 'component': {
          \ 'lineinfo': '%l:%-v'
        \ },
        \ 'component_expand': {
          \ 'linter_checking': 'lightline#ale#checking',
          \ 'linter_errors': 'lightline#ale#errors',
          \ 'linter_ok': 'lightline#ale#ok',
          \ 'linter_warnings': 'lightline#ale#warnings'
        \ },
        \ 'component_type': {
          \ 'linter_checking': 'left',
          \ 'linter_errors': 'error',
          \ 'linter_ok': 'left',
          \ 'linter_warnings': 'warning'
        \ },
        \ 'component_function': {
          \ 'gitbranch': 'fugitive#head',
          \ 'pwd': 'LightlineWorkingDirectory',
          \ 'fileinfo': 'LightlineFileinfo'
        \ }
      \ }

function! LightlineFileinfo()
  if winwidth(0) < 90
    return ''
  endif

  let encoding = &fenc !=# '' ? &fenc : &enc
  let format = &ff
  let type = &ft !=# '' ? &ft : 'no ft'
  return type . ' | ' . format . ' | ' . encoding
endfunction

function! LightlineWorkingDirectory()
  return &ft =~ 'help\|qf' ? '' : fnamemodify(getcwd(), ':~:.')
endfunction

" be silent when grabbing scp files
let g:netrw_silent = 1

" jsx
let g:jsx_ext_required = 0

" colors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:base16_shell_path = expand('~/src/base16/base16-shell/scripts')
if filereadable(expand('~/.vimrc_background'))
  let base16colorspace = 256
  source ~/.vimrc_background
endif
set background=dark
set termguicolors

" annoying sql
let g:omni_sql_no_default_maps = 1

" custom highlighting
" highlight Comment cterm=italic
