set encoding=utf-8
scriptencoding utf-8

" Charset, Line ending -----------------
set termencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set ffs=unix,dos,mac            " LF, CRLF, CR
if exists('&ambiwidth')
    set ambiwidth=double        " UTF-8の□や○でカーソル位置がずれないようにする
endif


""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" ファイルオープンを便利に
"NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
"NeoBundle 'Shougo/neomru.vim'


NeoBundle 'scrooloose/nerdtree'     " tree表示
" help: コマンドラインモードで:NERDTreeでツリー表示。qでツリー表示画面を閉じる。

NeoBundle 'tomtom/tcomment_vim'     " コメントON/OFF
" help: Ctrl + - + - (コントロール+ハイフン2回)でコメント化
"  note: Shift+Vで対象の範囲を選択


" vim に非同期処理を提供
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

"" 補完機能
"NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'


" color scheme
NeoBundle 'tomasr/molokai'

call neobundle#end()

" Required:
"filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=gray guibg=darkblue gui=none ctermfg=gray ctermbg=darkblue cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" 各種オプションの設定
""""""""""""""""""""""""""""""
set tags=~/.tags                " タグファイルの指定
set noswapfile                  " スワップファイルは使わない
set title                       " ウインドウのタイトルバーにファイルのパス情報等を表示
set history=2000                " q: で履歴表示

set ruler                       " カーソルが何行目の何列目に置かれているかを表示
set showcmd                     " 入力中のコマンドをステータス行に表示
set showmode                    " 現在のモードを表示
set cmdheight=2                 " コマンドラインに使われる画面上の行数
set laststatus=2                " エディタウィンドウの末尾から2行目にステータスラインを常時表示
set wildmenu                    " コマンドラインモードで<Tab>キーによるファイル名補完を有効
set wildmode=list:full          " リスト表示，最長マッチ

"set backupdir=$HOME/.vimbackup " バックアップディレクトリの指定

set ignorecase                  " 大文字小文字無視
set incsearch                   " インクリメンタルサーチ
set smartcase                   " 小文字のみで検索したときに大文字小文字を無視
set hlsearch                    " 検索結果をハイライト表示
set incsearch                   " 検索ワードの最初の文字を入力した時点で検索を開始
set wrapscan                    " 最後まで検索したら先頭へ戻る

set background=dark             " 暗い背景色に合わせた配色
set expandtab                   " タブ入力を複数の空白入力に置き換える
set hidden                      " 保存されていないファイルがあるときでも別のファイルを開ける

set list                        " 不可視文字を表示する
set display=uhex                " 印字不可能文字を16進数で表示

"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set listchars=tab:▸-,eol:¬      " 不可視文字表示


set number                      " 行番号を表示する
"set nowrap                      " 画面幅で折り返さない
set wrap                        " ウィンドウの幅より長い行は折り返して、次の行に続けて表示する

set matchpairs& matchpairs+=<:> " 対応括弧に<と>を追加
set showmatch                   " 対応する括弧を表示する
"set autoindent                 " 改行時に前の行のインデントを継続する
"set smartindent                " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set tabstop=4                   " タブ文字の表示幅
set shiftwidth=4                " Vimが挿入するインデントの幅(cindentやautoindent時に挿入されるインデントの幅)
set softtabstop=0               " Tabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
"set smarttab                   " 行頭の余白内で<Tab>を打ち込むと、shiftwidthの数だけインデント

au BufNewFile,BufRead *.py set nowrap tabstop=2 shiftwidth=2    " 拡張子でタブ幅を変更する
au BufNewFile,BufRead *.html set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.tpl set nowrap tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.smarty set nowrap tabstop=2 shiftwidth=2


set nostartofline               " 移動コマンドを使ったとき、行頭に移動しない
set whichwrap=b,s,h,l,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
set scrolloff=3                 " スクロールする時に下が見えるようにする
set autoread                    " 他で書き換えられたら自動で読み直す
"autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去
"autocmd BufWritePre * :%s/\t/ /ge   " 保存時にtabをスペースに変換
set fileformats=unix,dos,mac    " 改行コードの自動認識
set backspace=indent,eol,start  " バックスペースで各種消せるようにする
set vb t_vb=                    " ビープ音を消す
set novisualbell
set clipboard+=unnamed          " OSのクリップボードを使う
set clipboard=unnamed
"set mouse=a                     " ターミナルでマウスを使用できるようにする
"set guioptions+=a               " #ついCtrl+Cを使いそうになるので停止
"set ttymouse=xterm2


" ------------------------------------
" colorscheme
" ------------------------------------
set t_CO=<t_CO>                     " 256色表示
syntax on
colorscheme molokai

" colorschemeへ上書き
highlight Normal ctermbg=none       " iTerm2での半透明優先
highlight LineNr ctermfg=darkyellow " 行番号の色
highlight Comment ctermfg=49        " コメントの色


""""""""""""""""""""""""""""""
" キーマップ
""""""""""""""""""""""""""""""
"-------------------------------------------------------------------------------
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"-------------------------------------------------------------------------------

" emacs
map! <c-a> <home>
map! <c-e> <end>
nnoremap <c-a> <home>
nnoremap <c-e> <end>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz

" vを二回で行末まで選択
vnoremap v $h

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>

" コロンとセミコロンを入れ替え
"nnoremap ;  :
"nnoremap :  ;
"vnoremap ;  :
"vnoremap :  ;

""""""""""""""""""""""""""""""

" vimrcを編集したら即座に反映
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

filetype on
