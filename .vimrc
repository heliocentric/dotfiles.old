execute pathogen#infect()
syntax on
filetype plugin indent on
set number
highlight LineNr ctermfg=darkgrey
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='luna'
if has('gui_running')
	set guioptions -=T
	colorscheme rcg_gui
else
	colorscheme rcg_term
endif
