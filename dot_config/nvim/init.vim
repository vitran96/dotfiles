let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/refs/tags/0.14.0/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
"
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
"
" Lazy Loading example
" Plug 'https://github.com/scrooloose/syntastic.git', { 'on': 'SyntasticCheck' }
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#begin()

Plug 'scrooloose/nerdtree'

call plug#end()

set nu rnu
set noswapfile
set clipboard+=unnamedplus

set ttimeout
set ttimeoutlen=1
set ttyfast

nnoremap <C-i> i_<Esc>r
