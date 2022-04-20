" Set default shell
set shell=/bin/zsh

set number
set expandtab
set smartindent
set shiftwidth=2
set softtabstop=2
set autochdir
set encoding=utf-8
set fileencoding=utf-8
set clipboard+=unnamed,unnamedplus
set wildmode=longest,full

" Vundle-setting
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'doums/darcula'

" GUI enhancements
Plugin 'itchyny/lightline.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'andymass/vim-matchup'

" Semantic language support
Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/lsp_extensions.nvim'
Plugin 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plugin 'hrsh7th/cmp-nvim-lua', {'branch': 'main'}
Plugin 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plugin 'hrsh7th/cmp-path', {'branch': 'main'}
Plugin 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plugin 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plugin 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plugin 'hrsh7th/vim-vsnip'

" Syntactic language support
Plugin 'cespare/vim-toml'
Plugin 'stephpy/vim-yaml'
Plugin 'rust-lang/rust.vim'
Plugin 'rhysd/vim-clang-format'
"Plugin 'fatih/vim-go'
Plugin 'dag/vim-fish'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'


call vundle#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end


" darcula scheme
colorscheme darcula

syntax on

" Lightline
let g:lightline = {
      ¥ 'active': {
      ¥   'left': [ [ 'mode', 'paste' ],
      ¥             [ 'readonly', 'filename', 'modified' ] ],
      ¥   'right': [ [ 'lineinfo' ],
      ¥              [ 'percent' ],
      ¥              [ 'fileencoding', 'filetype' ] ],
      ¥ },
      ¥ 'component_function': {
      ¥   'filename': 'LightlineFilename'
      ¥ },
      ¥ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" rustfmt
let g:rustfmt_autosave = 1
