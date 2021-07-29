set number relativenumber
set signcolumn=no
set list lcs=tab:\|\ 
hi NonText ctermfg=gray

"" VIM PLUG
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim Ranger support
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

call plug#end()

" Coc-css
autocmd FileType scss setl iskeyword+=@-@

"" ALIASES
command Sassco w | ! sass --no-source-map custom.scss ../css/custom.css && xclip -sel c ../css/custom.css
