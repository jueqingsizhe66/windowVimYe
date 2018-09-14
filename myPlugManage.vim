call plug#begin('~/.vim/bundle')

"" where to store the plugins
"------------------
" Code Completions
"------------------
Plug 'Shougo/neocomplcache'
"Plug 'Shougo/neocomplete'
Plug 'ervandew/supertab'
"Plug 'honza/snipmate-snippets'
"""""""""""""""""""""""""""""""""""""""""""""""""""
" try anoother
" Plug 'scrooloose/snipmate-snippets'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
"""""""""""""""""""""""""""""""""""""""""""""""""""
"python
"Plug 'mattn/webapi-vim'
Plug 'Raimondi/delimitMate'
"------ snipmate dependencies -------
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

"-----------------
" Fast navigation
"-----------------
"Plug 'edsono/vim-matchit'
Plug 'jwhitley/vim-matchit'
Plug 'Lokaltog/vim-easymotion'
Plug 'justinmk/vim-sneak'
"--------------
" Fast editing
"--------------
Plug 'scrooloose/nerdcommenter'
"Plug 'sjl/gundo.vim'
Plug 'godlygeek/tabular'
Plug 'nathanaelkane/vim-indent-guides'

"--------------
" IDE features
"--------------
Plug 'scrooloose/nerdtree'
"Plug 'humiaozuzu/TabBar'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-easytags'" {{{1
Plug 'xolox/vim-misc'
Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'
Plug 'skwp/greplace.vim' " }}}1
""  file search tools
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'Valloric/MatchTagAlways'
Plug 'szw/vim-maximizer'
"" status line
Plug 'Lokaltog/vim-powerline'" {{{1
Plug 'scrooloose/syntastic'
Plug 'bronson/vim-trailing-whitespace'
Plug 'brookhong/cscope.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
"nerdtree }}}1
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'
"--------------
" Color Schemes
"--------------
"Plug 'altercation/vim-colors-solarized'  ;;需要时候再安装
Plug 'https://github.com/roosta/vim-srcery'" {{{1
Plug 'mhinz/vim-startify'
" }}}1


"marker
"Plug 'xsunsmile/showmarks'
Plug 'kshenoy/vim-signature'

"multicursor
Plug 'terryma/vim-multiple-cursors'
Plug 'nvie/vim-togglemouse'
Plug 'terryma/vim-expand-region'
Plug 'dimasg/vim-mark'
Plug 'dbmrq/vim-chalk'
Plug 'machakann/vim-highlightedyank'
"Plug 'dbmrq/vim-redacted'
"show repeated words,r
"Plug 'dbmrq/vim-ditto'   ;; 感觉速度变慢 于是删掉
""support csv

"strength the NerdTree, multiTags with one NerdTree

" 通过ctrlp替换ctrl-space
"Plug 'vim-ctrlspace/vim-ctrlspace'


"strength the tarbar
"Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-misc'
"Plug 'elentok/todo.vim'


":MRU
Plug 'vim-scripts/mru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
"Plug 'Shougo/vimproc.vim'
"sources for unite
Plug 'Shougo/unite-outline'
Plug 'Shougo/neomru.vim'
Plug 'sgur/unite-everything'
" Plug 'Shougo/vimproc.vim', {
" \ 'build' : {
" \     'windows' : 'tools\\update-dll-mingw',
" \     'cygwin' : 'make -f make_cygwin.mak',
" \     'mac' : 'make',
" \     'linux' : 'make',
" \     'unix' : 'gmake',
" \    },
" \ }                      -
"
"
"" abbre
Plug 'chip/vim-fat-finger'

"Plug 'vim-scripts/Vim-R-plugin'
"Plug 'wdicarlo/vim-notebook'  ;;; 有了vimwiki就不用阿勒
"" code align vertical bar
Plug 'Yggdroot/indentLine'

" modve the code textobject
Plug 'matze/vim-move'

"" update the operation of f and F t and T
Plug 'rhysd/clever-f.vim'
"" color to let you look better  set termguicolors
Plug 'romainl/Apprentice'

"Plug 'itchyny/calendar.vim'
Plug 'mattn/calendar-vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-after-object'
Plug 'amix/vim-zenroom2'
"Plug 'junegunn/vim-github-dashboard'
" Multiple commands
"Plug 'junegunn/vim-github-dashboard'
"plantuml
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'

Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
"git 1
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
""for conventer
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/vim-asterisk'
"" see your yawed part
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'

"" underline the word at the current current
"Plug 'itchyny/vim-cursorword'
Plug 'henrik/vim-indexed-search'
Plug 'AndrewRadev/splitjoin.vim'

" another kana object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
"" va` vi`
""Plug 'fvictorio/vim-textobj-backticks'
Plug 'jceb/vim-textobj-uri'
Plug 'kana/vim-textobj-fold'


"" copy filename
Plug 'AdamWhittingham/vim-copy-filename'

Plug 'will133/vim-dirdiff'
Plug 'vim-scripts/sketch.vim'
Plug 'hrj/vim-DrawIt'

"" Improve the nerd tree
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ryanoasis/nerd-fonts'  "it should be download,not bundle

"Plug 'https://github.com/dracula/vim'
"Plug 'dracula/dracula-theme'


"-----------------------------------------------------------------------------------"
"" If you needed uncomment  it!
"" language specified start---------------------------------------------------------"
"Plug 'vim-scripts/SQLComplete.vim'
"html
""------- web frontend ----------
"Plug 'othree/html5.vim'
"Plug 'mattn/emmet-vim'
" Plug 'tpope/vim-haml'
"Plug 'pangloss/vim-javascript'
"Plug 'kchmck/vim-coffee-script'
"Plug 'nono/jquery.vim'
" For java
" Plug 'yuratomo/java-api-complete'
" Plug 'yuratomo/java-api-javax'
" Plug 'yuratomo/java-api-org'
" Plug 'yuratomo/java-api-sun'
" Plug 'yuratomo/java-api-servlet2.3'
"Plug 'yuratomo/java-api-android'
" Plug 'yuratomo/java-api-junit'
"Plug 'artur-shaik/vim-javacomplete2'
"------- markup language -------
Plug 'tpope/vim-markdown'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/txt.vim'
" Plug 'timcharper/textile.vim'
" ************************************************************
"  ---------------------racket related plugin------------------
" Plug 'wlangstroth/vim-racket'
"Plug 'vim-scripts/scribble.vim'
"  ---------------------racket related plugin------------------
" ************************************************************
" Plug 'vim-scripts/VimClojure'
" Plug 'rosstimson/scala-vim-support'
"matlab
Plug 'elmanuelito/vim-matlab-behave'
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'
"Plug 'freitass/todo.txt-vim'
"Plug 'lervag/vimtex'
"Plug 'jcf/vim-latex'
"Plug 'lukerandall/haskellmode-vim'
Plug 'vim-perl/vim-perl'
Plug 'WolfgangMehner/vim-plugins'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'kovisoft/slimv'
"Plug 'adimit/prolog.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'chrisbra/csv.vim'
"Plug 'wannesm/wmgraphviz.vim'
Plug 'vim-scripts/gnuplot.vim'
Plug 'mdlerch/vim-gnuplot'
" R lanagage
"Plug 'jalvesaq/Nvim-R'
Plug 'vim-scripts/paredit.vim'
Plug 'rkulla/pydiction'
Plug 'vimwiki/vimwiki'

"clojure
"Plug 'tpope/vim-fireplace'
"" language specified end----------------------------------------------------------"
"-----------------------------------------------------------------------------------"

call plug#end()


filetype plugin indent on     " required!

