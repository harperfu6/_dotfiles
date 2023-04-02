" installed to ~/.local/share/nvim/plugged
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

if has('nvim')
  " airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " fzf (ambiguous search)
  Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 }
  Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }

	" fugitive
	Plug 'tpope/vim-fugitive'

  " comment
  Plug 'tpope/vim-commentary'

	" surround
	Plug 'tpope/vim-surround'

  " directory tree
  Plug 'preservim/nerdtree'

  " LSP
  Plug 'neoclide/coc.nvim', {'branch': 'release'} 

  " ALE (Asynchronous Lint Engine)
  " Plug 'w0rp/ale'
	
  " MarkDown
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

  " Prettier (format on save)
  Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'branch': 'release/0.x'
  \ }

	" code-action-menu
	Plug 'weilbith/nvim-code-action-menu'

	" snippet
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'

  """""""""""""""""""
  " language plugin
  """""""""""""""""""
  " rust
  Plug 'rust-lang/rust.vim'
  " emmet (html)
  Plug 'mattn/emmet-vim'
  " toml
  Plug 'cespare/vim-toml'
  " jsx/tsx
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
	" prisma
	Plug 'pantharshit00/vim-prisma'
	" graphql
	Plug 'jparise/vim-graphql'
	" qmd(quarto)
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'quarto-dev/quarto-vim'
	" python
	Plug 'vim-python/python-syntax'

else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


" Initialize plugin system
call plug#end()
