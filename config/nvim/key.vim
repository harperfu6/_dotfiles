"-------------------------------------------------------------------------------
" 移動系
"-------------------------------------------------------------------------------

" カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> gj
nnoremap <Up>   gk

" 1, 0で行頭、行末へ
noremap 1 ^
noremap 0 $

" 対応する括弧に移動
nnoremap ( %
nnoremap ) %

" insert mode での移動
inoremap  <C-p> <Up>
inoremap  <C-n> <Down>
inoremap  <C-e> <END>
inoremap  <C-a> <HOME>
inoremap  <C-F> <Right>
inoremap  <C-B> <Left>
inoremap  <C-D> <Del>

"-------------------------------------------------------------------------------
" 最後に編集した場所に移動する系
"-------------------------------------------------------------------------------
" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 最後に編集された位置に移動
nnoremap gb '[
nnoremap gp ']

"-------------------------------------------------------------------------------
" 編集系
"-------------------------------------------------------------------------------
" Yを行末までヤンクに変更
nnoremap Y y$

" カーソル位置の単語をyankする
nnoremap vy vawy

" 挿入モードでCtrl+pを押すとクリップボードの内容を貼り付けられるようにする "
imap <C-p>  <ESC>"*pa

" コマンドモードのEv/Rvでvimrcの編集と反映
" export MYVIMRC=~/_dotfiles/.vimrc
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

" markdown
function! MdStrike()
	let num_tab = count(getline("."), "\t")
	if num_tab > 0
		let tab_str = repeat("\t", num_tab)
		s/\t\+//
	else
		let tab_str = ''
	endif
	call setline('.', tab_str . '- ~~' . getline('.') . '~~')
endfunction

function! MdBold()
	let num_tab = count(getline("."), "\t")
	if num_tab > 0
		let tab_str = repeat("\t", num_tab)
		s/\t\+//
	else
		let tab_str = ''
	endif
	s/- //
	call setline('.', tab_str . '- **' . getline('.') . '**')
endfunction

function! MdCheckbox()
	let num_tab = count(getline("."), "\t")
	if num_tab > 0
		let tab_str = repeat("\t", num_tab)
		s/\t\+//
	else
		let tab_str = ''
	endif
	s/- //
	call setline('.', tab_str . '- [ ] ' . getline('.'))
endfunction

function! MdBoxChecked()
	let num_tab = count(getline("."), "\t")
	if num_tab > 0
		let tab_str = repeat("\t", num_tab)
		s/\t\+//
	else
		let tab_str = ''
	endif
	s/- //
	let is_box = count(getline("."), "[ ]")
	if is_box > 0
		s/\[ \] //
	endif
	call setline('.', tab_str . '- [x] ' . getline('.'))
endfunction

nnoremap ms :call MdStrike()<CR>
nnoremap mb :call MdBold()<CR>
nnoremap mc :call MdCheckbox()<CR>
nnoremap mx :call MdBoxChecked()<CR>

"-------------------------------------------------------------------------------
" 画面操作系
"-------------------------------------------------------------------------------
nnoremap ,v :<C-u>vsplit<CR>
nnoremap ,h :<C-u>split<CR>
nnoremap ,c :<C-u>close<CR>
nnoremap ,o :<C-u>only<CR>

"move window
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l

"<space>j, <space>kで画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

"-------------------------------------------------------------------------------
" Esc系
"-------------------------------------------------------------------------------
" insert mode でjjでesc
inoremap jj <Esc>

"-------------------------------------------------------------------------------
" バッファ系
"-------------------------------------------------------------------------------
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>bb :b#<CR>
nnoremap <silent>bd :bdelete<CR>

"-------------------------------------------------------------------------------
" タブ系 URL(https://qiita.com/wadako111/items/755e753677dd72d8036d)
"-------------------------------------------------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>


