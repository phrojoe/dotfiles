execute pathogen#infect()

syntax enable			  " enable syntax processing
set tabstop=2			  " spaces per tab
set softtabstop=2	  " spaces in inserted tabs
set shiftwidth=2    " numberof spaces in auto indent
set expandtab		    " tabs are spaces
set smartindent     " does the right thing
set nu						  " line numbers
set showcmd				  " last command in bottom bar
set cursorline		  " highlight current line
set ruler						" row and col info
set wildmenu        " visual autocomplete for commands
set wildmode=longest,list,full
set lazyredraw		  " less redrawing
set showmatch			  " hightlight matching brackets
set incsearch			  " incremental search
set hlsearch			  " hightlight search matches
" set mouse=nicr      " we aren't heathens

 " autocomplete?
set omnifunc=syntaxcomplete#Complete
set completeopt=preview,menuone

let c_no_curly_error=1

" buffers shortcut
nnoremap gb :ls<CR>:buffer<Space> 

" backup file settings
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

filetype plugin on
au BufNewFile,BufRead *.hbs set filetype=html

map <C-n> :NERDTreeTabsToggle<CR>

if executable('rg')
" CtrlP
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
" ack.vim
  let g:ackprg = 'rg --vimgrep --no-heading'
endif


colors zenburn
