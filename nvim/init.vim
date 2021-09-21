"  __   _____ __  __ ___  ___ 
"  \ \ / /_ _|  \/  | _ \/ __|
"   \ V / | || |\/| |   / (__ 
"    \_/ |___|_|  |_|_|_\\___|
"    ========================
" Author: @Ermaolaoye
" Press <Leader>+; to fold&unfold settings
let g:mapleader= "\<Space>"
let g:maplocalleader = ","
let g:which_key_map = {}

" ==== Vimscript file settings ==== {{{
" Autofolding
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevelstart
augroup END
" }}}

" ==== Terminal settings ==== {{{
autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
autocmd TermOpen * startinsert
" }}}

" ==== Basic Settings ==== {{{
" Turn on syntax highlighting
syntax on
" Turn off compatible for the original vi editor
set nocompatible
" Display the number line
set number
" Use Relative numbers
set relativenumber
" Turn on cursorline
set cursorline
" Custom indentation per file type
filetype plugin indent on
" Highlight search
set hlsearch
" Show lighting when typing to search
set incsearch
" Use UTF-8 Encoding as default
set encoding=utf-8
" Auto Indentation
set autoindent
" Smart Indentation
set smartindent
" History
set history=1000
" Fast update time
set updatetime=300
" Timeout Time
set timeoutlen=500
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes
" Set pop-up menu color
hi Pmenu ctermbg=black ctermfg=white
" Turn on mouse input
set mouse=a
" }}}

" ==== Plugin Manager ==== {{{
" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
call plug#begin('~/.vim/plugged')
" Chinese Vim Documentation
Plug 'yianwillis/vimcdoc'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" coc.nvim - Conquer of Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" WhichKey
Plug 'liuchengxu/vim-which-key'
" Startify
Plug 'mhinz/vim-startify'
" markdown-preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" indent-line
Plug 'Yggdroot/indentLine'
" rainbow
Plug 'luochen1990/rainbow'

call plug#end()
" }}}

" ==== Hotkey Settings ==== {{{
" ==== Basic Hotkeys
" H front of line | L end of line
nnoremap H 0
nnoremap L $
" jk to exit input mode
inoremap jk <esc>
" ==== e - Environment
let g:which_key_map['e'] = {
		\ 'name' : '+environment',
		\ 'h' : [':help' 			, 'help'] 				,
		\ 'v' : [':vsplit $MYVIMRC' 		, 'open-vim-configuration-file'] 	,
		\ 's' :  		 		  'source-vim-configuration-file' 	,
	  \ }
nnoremap <leader>es :source $MYVIMRC<CR>
" ==== f - Files
let g:which_key_map['f'] = {
		\ 'name' : '+files' ,
		\ 'w' : [':w' 				, 'save-file'] 				,
		\ 'q' : [':q' 				, 'exit-file'] 				,
		\ 'Q' : [':q!' 				, 'forcely-quit-file'] 			,
	  \ }
" ==== p - Plugin
let g:which_key_map['p'] = {
		\ 'name' : '+plugins' ,
		\ 'i' : [':PlugInstall' 		, 'plugin-install'] 			,
		\ 'c' : [':PlugClean' 			, 'plugin-clean'] 			,
		\ 'u' : [':PlugUpdate' 			, 'plugin-update'] 			,
		\ 'U' : [':PlugUpgrade' 		, 'update vim-plug'] 			,
		\ 's' : [':PlugStatus' 			, 'plugin-status'] 			,
	  \ }
" ==== w - Windows
let g:which_key_map['w'] = {
		\ 'name' : '+windows' ,
		\ 'h' : ['<C-w>h' 			, 'change-focus-left'] 			,
		\ 'j' : ['<C-w>j' 			, 'change-focus-down'] 			,
		\ 'k' : ['<C-w>k' 			, 'change-focus-up'] 			,
		\ 'l' : ['<C-w>l' 			, 'change-focus-right'] 		,
		\ 's' : {
		  \ 'name' : '+split' 								,
		  \ 'h' : 				  'split-left' 				,
		  \ 'j' : 				  'split-down' 				,
		  \ 'k' : 				  'split-up' 				,
		  \ 'l' : 				  'split-right' 			,
	  \ }
	  \ }
nnoremap <leader>wsh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nnoremap <leader>wsj :set splitbelow<CR>:split<CR>
nnoremap <leader>wsk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
nnoremap <leader>wsl :set splitright<CR>:vsplit<CR>
" ==== Else
" ; to fold/unfold
let g:which_key_map[';'] = 'fold-or-unfold'
nnoremap <leader>; za
" Opening a terminal window
let g:which_key_map['/'] = 'open-terminal'
nnoremap <leader>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>
tnoremap <Esc> <C-\><C-n> 

" ==== Plugin Hotkeys
" Coc.nvim {{{
" tt to open CocCommand
nnoremap tt :CocCommand<CR>
nnoremap tl :<C-u>CocList<CR>
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-r> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
let g:which_key_map['d'] = {
		\ 'name' : '+documentation' ,
		\ 'd' : 				 'coc-definition' ,
		\ 't' : 				 'coc-type-definition' ,
		\ 'i' : 				 'coc-implementation' ,
		\ 'r' : 				 'coc-references' ,
	  \ }
nmap <leader>dd <Plug>(coc-definition)
nmap <leader>dt <Plug>(coc-type-definition)
nmap <leader>di <Plug>(coc-implementation)
nmap <leader>dr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rennme)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)


" }}}
" }}}

" ==== Abbreviations Settings ==== {{{
" Quick Information Replacement
" emly! to Ermaolaoye
iabbrev emly! Ermaolaoye
" email! to ermaolaoye233@gmail.com
iabbrev email! Email Address : ermaolaoye233@gmail.com
" qq! to 735061038
iabbrev qq! Tencent QQ : 735061038
" wechat! to howard_meow
iabbrev wechat! WeChat ID : ermaolaoye 
" contact! to all contact information
iabbrev contact! Ermaolaoye<return>Email Address : ermaolaoye233@gmail.com<return>Tencent QQ : 735061038<return>WeChat ID : ermaolaoye<return>
" sign! to == Copyright 2021 Ermaolaoye, all rights reserved.
iabbrev sign! == Copyright 2021 Ermaolaoye, all rights reserved.
" }}}

" ==== Compile and Run ==== {{{
autocmd filetype cpp nnoremap <leader>r :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd FileType python map <buffer> <leader>r :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"}}}

" ==== Plugin Settings ==== {{{
" coc.nvim
let g:coc_global_extensions = [
	\'coc-json', 
	\'coc-vimlsp',
	\'coc-marketplace',
	\'coc-pyright',
	\'coc-explorer',
	\'coc-clangd',
	\'coc-calc',
	\'coc-prettier',
	\'coc-pairs',
	\'coc-html',
	\'coc-cmake']
" __coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" vim-which-keys
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :WhichKey ','<CR>

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let g:airline_theme='papercolor'

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler signcolumn=no
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

""" Indent-line
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indentLine_char = '┆'

let g:indentLine_fileTypeExclude = ['text', 'sh', 'which_key']

""" rainbow
let g:rainbow_active = 1
"}}}
