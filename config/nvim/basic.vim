"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac           " 改行文字
set encoding=utf-8             " デフォルトエンコーディング
let mapleader = ","            " キーマップリーダー
set scrolloff=5                " スクロール時の余白確保
set textwidth=0                " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                   " バックアップ取らない
set autoread                   " 他で書き換えられたら自動で読み直す
set noswapfile                 " スワップファイル作らない
set hidden                     " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions=lmoq         " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                   " ビープをならさない
set browsedir=buffer           " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set showcmd                    " コマンドをステータス行に表示
set showmode                   " 現在のモードを表示
set viminfo='50,<1000,s100,\"50 " viminfoファイルの設定
" set modelines=0              " モードラインは無効
set splitright                 " 新しいウィンドウを右に開く
"set fencs=iso-2022-jp,sjis,euc-jp " JAPANESE!
set noundofile                 " undoファイル(.*.un~)を作成しない
let netrw_dirhistmax = 0       " .netrwhistファイルを作成しない
set noswapfile                 " スワップファイル(.*swp)を作成しない
set lazyredraw                 " コマンド実行中は再描画しない
set ttyfast                    " 高速ターミナル接続を行う(スクロールが重くなる時の対策)
set mouse=a                    " ターミナルでマウスを使用できるようにする
set guioptions+=a              " ターミナルでマウスを使用できるようにする

" クリップボードを有効にする
let s:uname = system("uname -s")
if s:uname == "Linux\n" " for ubuntu
  set clipboard=unnamedplus
elseif s:uname == "Darwin\n" " for mac
  set clipboard+=unnamed
else
  echo "cannot set clipboard"
endif

"挿入モードをぬけたとき、自動的にIMEをoff"
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" コマンドモードのEv/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
command! Rg source $MYGVIMRC

" ファイルタイプ判定をon
filetype plugin on

" 自動的にペーストモードにする
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

