" Disable plugins on non-gui versions
"if !has('gui_running')
"  call add(g:pathogen_blacklist, 'csscolor')
"endif

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
execute pathogen#infect()

nnoremap <leader>L  :set list!<CR>
nnoremap <leader>e  :Explore<CR>
nnoremap <leader>es :Sexplore<CR>
nnoremap <leader>ev :Vexplore<CR>
nnoremap <leader>t  :set guifont=Monaco:h10<CR>
nnoremap <leader>T  :set guifont=Monaco:h16<CR>
"nnoremap <C-g><C-r> :YcmRestartServer<CR>
nnoremap <C-g><C-G> :YcmCompleter GoTo<CR>
nnoremap <C-g><C-f> :YcmCompleter GoToReferences<CR>
nnoremap <C-g><C-r> :YcmCompleter RefactorRename 
nnoremap <C-g><C-i> :YcmCompleter OrganizeImports<CR>
nnoremap <C-g><C-h> :ALEFix<CR>

map <silent> <leader>q :call qf#toggle#ToggleQfWindow(0)<CR>
map <silent> <leader>l :call qf#toggle#ToggleLocWindow(0)<CR>
let g:qf_loclist_window_bottom = 0
let g:qf_mapping_ack_style = 1

" copy full path
:command CopyPath let @+ = expand("%:p")
" copy just filename
:command CopyFilename let @+ = expand("%:t")
" copy branch
:command CopyBranch let @+ = fugitive#head()

if has("patch-8.1.0251")
  if !isdirectory($HOME . "/.vim/backup")
    call mkdir($HOME . "/.vim/backup", "p", 0711)
  endif
  set writebackup
  set nobackup
  set backupcopy=auto
  set backupdir^=~/.vim/backup//
end
if !isdirectory($HOME . "/.vim/swap")
  call mkdir($HOME . "/.vim/swap", "p", 0711)
endif
set swapfile
set directory^=~/.vim/swap//
if !isdirectory($HOME . "/.vim/undo")
  call mkdir($HOME . "/.vim/undo", "p", 0711)
endif
set undofile
set undodir^=~/.vim/undo//


if has('gui_running')
  " GUI only
  set guioptions-=rL
  set guioptions+=ck
  set guicursor+=a:blinkon0
  set noantialias
  set guifont=Monaco:h10
  colorscheme vividchalk

  nnoremap <silent> <C-q> :call qf#toggle#ToggleQfWindow(0)<CR>
else
  " Console only
  set ttyfast

  if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
  endif

  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

autocmd! GUIEnter * set vb t_vb=
set t_Co=256
set background=dark
syntax enable
filetype plugin indent on

set ts=2 sts=2 sw=2 et
set enc=utf8
filetype on
set hlsearch
syn on
set mouse=a
set backspace=indent,eol,start

set timeout
set timeoutlen=600
set synmaxcol=256

set noea
set nocompatible
set nrformats-=octal
set smarttab
set incsearch
set laststatus=2
set wildmenu
set display+=lastline
set autoread
set showcmd

" Display line movements, except with count
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

set updatetime=1000

let g:netrw_banner=0
let g:netrw_fastbrowse=0

if !&scrolloff
  set scrolloff=1
endif

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

set formatoptions+=j " Delete comment character when joining commented lines

set breakindent
set showbreak=\\\\\
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

augroup misc_commands
  autocmd!
  " Set working directory to current file
  au BufEnter * silent! lcd %:p:h

  au FileType netrw set nolist
  au FileType gitcommit set nolist
  "au FileType netrw au BufEnter <buffer> set nolist
  "au FileType netrw au BufLeave <buffer> set list
augroup END

set completeopt=longest,menuone,noinsert
set splitbelow

" YouCompleteMe
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '--'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_always_populate_location_list = 0
"let g:ycm_autoclose_preview_window_after_insertion=1
" Fix weird quickfix window behaviour when using :YcmCompleter GoToReferences
" https://github.com/Valloric/YouCompleteMe/issues/3272
autocmd User YcmQuickFixOpened autocmd! WinLeave

" Searching & Ack (Ag)
" Put word under cursor into search register and highlight
nnoremap <silent> <Leader>* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
vnoremap <silent> <Leader>* :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:let @/=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>:set hls<CR>

:function GcdOrNot()
:  if exists(":Gcd")
:    :Gcd
:  endif
:endfunction
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
cnoreabbrev ag call GcdOrNot() <bar> Ack! -Q 
nnoremap <Leader>a :Ack!<Space>
nnoremap • :call GcdOrNot() <bar> Ack! <C-r><C-w>
vnoremap • \* "my:call GcdOrNot() <bar> Ack! <C-r>=fnameescape(@m)

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Filetype: Python
augroup python_commands
  autocmd!
  au BufEnter *.py set ts=4 sts=4 sw=4 et
  au BufEnter *.pyw set ts=4 sts=4 sw=4 et
augroup END

" Filetype: JavaScript
augroup js_commands
  autocmd!
  au FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
augroup END
let g:jsx_ext_required = 0

" ALE
" For a more fancy ale statusline
" https://github.com/liuchengxu/space-vim/blob/master/layers/%2Bcheckers/syntax-checking/config.vim
function! ALEGetError()
  if exists('g:loaded_ale')
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:all_errors == 0 ? '' : printf(' ‡%d ', l:all_errors)
  endif
  return ''
endfunction
function! ALEGetWarning()
  if exists('g:loaded_ale')
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_warnings = l:counts.warning + l:counts.style_warning
    return l:all_warnings == 0 ? '' : printf(' •%d ', l:all_warnings)
  endif
  return ''
endfunction
function! ALEGetOk()
  if exists('g:loaded_ale')
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:issues = l:counts.error + l:counts.style_error + l:counts.warning + l:counts.style_warning
    return l:issues == 0 ? ' ok ' : ''
  endif
  return ''
endfunction

"let g:ale_completion_enabled = 1
let g:ale_linters = {
\  'javascript': ['tsserver', 'eslint'],
\  'typescript': ['tsserver'],
\  'cs': []
\}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_delay = 300
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['eslint'],
\  'typescript': ['tslint', 'prettier'],
\}
"let g:ale_fix_on_save = 1
let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'
let g:ale_set_signs = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_set_highlights = 1
"highlight ALEError ctermbg=88
highlight link ALEError SpellBad
highlight link ALEWarning SpellCap

" Fugitive
function! S_fugitive()
  if exists('g:loaded_fugitive')
    let l:head = fugitive#head()
    return empty(l:head) ? '' : '  ⎇ '.l:head . ' '
  endif
  return ''
endfunction

" Status line
hi syn_error cterm=None ctermfg=197 ctermbg=237 gui=None guifg=#CC0033 guibg=#3a3a3a
hi syn_warn  cterm=None ctermfg=214 ctermbg=237 gui=None guifg=#FFFF66 guibg=#3a3a3a
hi syn_ok    cterm=None ctermfg=LightGreen ctermbg=237 gui=None guifg=#00FF66 guibg=#3a3a3a

" start of default statusline
set statusline=%f\ %h%w%m%r\ 
" ALE statusline
set statusline+=%#syn_error#%{ALEGetError()}%*
set statusline+=%#syn_warn#%{ALEGetWarning()}%*
set statusline+=%#syn_ok#%{ALEGetOk()}%*
" end of default statusline (with ruler)
set statusline+=%{S_fugitive()}
set statusline+=%=%(%l,%c%V\ %=\ %P%)\ 

" vim:set ft=vim et sw=2:
