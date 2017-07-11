"--------------------
"
" 基本的な設定
"--------------------
"
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileformats=unix,dos,mac

set nf=

"
" 改行をノーマルモードでEnterキーで
noremap <CR> o<ESC>

"新しい行のインデントを現在行と同じにする
set autoindent
 
"クリップボード
set clipboard=unnamed,autoselect
 
"vi互換をオフする
set nocompatible
 
 
"タブの代わりに空白文字を指定する
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" バックスペースでインデントや改行を削除
set backspace=2
 
"変更中のファイルでも、保存しないで他のファイルを表示する
set hidden
 
"インクリメンタルサーチを行う
set incsearch
 
"行番号を表示する
set number
 
"閉括弧が入力された時、対応する括弧を強調する
set showmatch
 
"新しい行を作った時に高度な自動インデントを行う
"set smarttab
 
" grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
 
" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>

" 現在行をハイライト
set cursorline
highlight CursorLine term=reverse cterm=reverse

" zencodingの設定
let g:user_emmet_settings = {
        \  'lang': 'ja',
        \  'html': {
        \    'filters': 'html',
        \    'indentation': ''
        \  }
        \}

" swp & backup  output directory
set swapfile
set directory=~/.vimswap

set backup
set backupdir=~/.vimbackup


filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" originalrepos on github
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/livestyle-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'matchit.zip'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'taichouchou2/html5.vim'
"NeoBundle 'taichouchou2/vim-javascript'
"NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'jlebensold/reilly_restaurants'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'isRuslan/vim-es6'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/newspaper.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/darkburn'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'thinca/vim-quickrun'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'mtscout6/vim-cjsx'
NeoBundle 'kannokanno/previm'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'szw/vim-tags'

call neobundle#end()
filetype plugin indent on     " required!
filetype indent on
syntax on

" colorscheme設定
colorscheme hybrid

" statusline設定
:set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
                                \  &ft == 'unite' ? unite#get_status_string() : 
                                \  &ft == 'vimshell' ? vimshell#get_status_string() :
                                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
        return &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head()) ? '⭠ '.fugitive#head() : ''
endfunction

function! MyFileformat()
        return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
        return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
        return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
        return winwidth('.') > 60 ? lightline#mode() : ''
endfunction


" gitの差分を表示
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>


"unite {{{
 
"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>f [unite]
 
"インサートモードで開始しない
let g:unite_enable_start_insert = 0
 
" For ack.
if executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt = ''
endif
 
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
 
"bookmarkだけホームディレクトリに保存
let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'
 
 
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
"augroup vimrc
"  autocmd FileType unite call s:unite_my_settings()
"augroup END


"vimfiler {{{
"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
"nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
" 引数なしの場合は VimFilerを起動
if has('vim_starting') &&  expand("%") == ""
  " Source
  NeoBundleSource vimfiler
  autocmd VimEnter * VimFiler
endif

" minibufexplの設定
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

" -------------------- Previm ----------------------------- "
"let g:previm_open_cmd = 'open -a Firefox'
"augroup PrevimSettings
  "autocmd!
  "autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
"augroup END

" -------------------- QuickRun ----------------------------- "
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\   'outputter': 'browser'
\ }

let g:quickrun_config['vim'] = { 
\   "hook/output_encode/enable" : 1,
\   "hook/output_encode/encoding" : "utf-8",
\}


" ctags用のvim-tags設定
au BufNewFile,BufRead *.php let g:vim_tags_project_tags_command = "ctags --languages=php -f ~/php.tags `pwd` 2>/dev/null &"


