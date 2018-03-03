# 主要目的
快速编辑文件

[learn-vim-progressively][1]
[vim-as-IDE][2]

<font color="red">sorry for bundle/文件夹没有上传</font>

如果您依然想用，那么只好忽略警告,然后`Plug Install`一下即可

```
记得更改ag.exe,perl.exe,es.exe,git.exe 哈，在.vimrc的第943行，搜索一下即可
并且把.vim目录下的ag.exe添加到path路径下，这样你就可以愉快的`,a`,命令行显示`:Ack everything`
```

## \<leader\>q: search context in files with ag, let you fly

十分有用的功能,q(查找光标下的单词) 空格斜杠查找项目中的单词

```
" --- type to search the word in all files in the current dir
nmap <leader>q :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag


```

同时也改进了ctrlspace的设置

```
if executable("ag")
        let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
```

## \<space\>\<space\>: search file in project directory with unite file_rec, let you fly too
Stackoverflow , author of Shoudo(去查看[vim-as-IDE][2])

without vimproc(for async ,can be used in linux, had better not in windows)
```
In Windows, you should not use file_rec/async source. It is too slow and not easy to use. You should use file_rec source instead.
```

注意在windows使用起来最好使用[vimproc.dll][7]放在c:/windows/system32/底下即可.

所以你现在就可以在项目文件夹使用\<Space\> \<space\>来打开搜索文件夹目录搜索文件，可快可爽的感觉。


## :Gdiff : fugitive Gdiff eye your difference of files

wow, good, let you what is different with the latest version!!

Gread, let you reset the changes from the latest commit version(东西没有了额！！)
Gwrite, stash what the changes.(暂存起来)



## vim-tags

[blog: vim and ctags][3]

[zsw/vim-tags][4]

```
:TagsGenerate

This command will generate one or more tags files but only if the main tags file exists. The presence of that file acts as an indicator actually. By the main tags file I mean the "tags" file collecting tags from all files and subdirectories of the project root directory.
```

[ctags.exe][5](注意emacs底下的ctags.exe无法使用-R，一定得是 [exuberant-ctags][8]

如果当前文件夹就是项目文件夹: `ctags -R .`  ([ctags源代码][6])


```
The most significant one is that Universal-ctags doesn't load ~/.ctags and ./.ctags at starting up time. Instead, it loads ~/.ctags.d/*.ctags and ./.ctags.d/*.ctags
```


## vim-cscope


[cscope.exe][10] 得配套gnu的sort.exe否则报如下错误

```
G:\IntellijHome\hutool>cscope -Rbq
cscope: -q option mismatch between command line and old symbol database

sort: cannot read: /tmp/cscope.16808/cscope.1: No such file or directory
cscope: cannot create inverted index; ignoring -q option
cscope: removed files ncscope.in.out and ncscope.po.out
```


[解决办法][9]
```
D:\Temp> type cs.bat
@echo off
set path=f:\cygwin\bin;
cscope -Rbkq
```


问题2：

```
出现E623 无法生成cscope进程”
```

解决办法:

```
在命令行窗口下可以直接用cscope命令了吗？用cscope -h试试，看能不能执行成功
如果已经可以，你所csprg的名字(在.vimrc中设置)设置成下面的试试：
set csprg=cscope
```


使用方法：

1. 使用`ag -l > cscope.files` 生成该文件，（默认cscope只处理*.c *.lex *.yal文件，不处理*.java *.c++等），所以需要手动搜索一下
2. 使用`set path=f:\cygwin\bin;cscope -bq` 生成索引文件
3. 打开vim, 定位到cscope.out 所在目录，使用`cscope add cscope.out`即可或者`cscope add .`
4. 现在既可以查找数据了 ，使用`,fs`查找光标下符号(`,fg`特指光标下函数的定义), 使用`,fc`查看谁调用了光标下的函数,比较特殊的是`,fd`查找光标下
函数中所有的函数们


.vimrc 设置
```

if has("cscope")
   "  set csprg="F:\cygwin\bin\cscope.exe"              "指定用来执行 cscope 的命令
     set csprg=cscope              "指定用来执行 cscope 的命令
   set csto=1                             "先搜索tags标签文件，再搜索cscope数据库
   set cst                                "使用|:cstag|(:cs find g)，而不是缺省的:tag
   set nocsverb                           "不显示添加数据库是否成功
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out                   "添加cscope数据库
   endif
   set csverb                             "显示添加成功与否
endif
"cscope"
   " in case your cscope execute is not in system path.
    " let g:cscope_cmd = 'D:/tools/vim/cscope.exe'
    " s: Find this C symbol
    map <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
    " g: Find this definition
    map <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
    " d: Find functions called by this function
    map <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
    " c: Find functions calling this function
    map <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
    " t: Find this text string
    map <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
    " e: Find this egrep pattern
    map <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
    " f: Find this file
    map <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
    "" i: Find files #including this file
    map <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
    map <leader>l :call ToggleLocationList()<CR>


```

```
使用方法
ag 'hx' /www/t086.com

常用参数
-i 忽略大小写
-l 只列出文件名
-g 文件名匹配
--php 只搜索php文件
--ignore-dir 忽略目录
```


## 当前vim工作流程

1. 打开文件，编写(涉及到git提交问题，一般选择emacs的magit形式，进行工作，就比如现在我正在emacs编写)
2. 需要记录知识，概念，打开calendar(我已经在.vimrc)配置好，所以可以直接使用`,ca`打开calendar，调到当前日期写日记,当然直接打开当前日子`,wt`
然后有可能使用`xdate`产生日期，很有意思的是enter一下即可产生链接(vimwiki做得不错），然后还可以使用backspace回到`,wi` diary总管理界面，可不舒爽
的一个编辑过程，两个键方便写来读去，很是方便 ,进一步参考[what vim teatches you][11]
3. 双空格进行搜索【unite】，`,a`进行查找【unite+ag】，`,q`查找光标下单词【unite+ag】，使用`F2`打开ctrlspace文件管理器(h:Home(Buffer mode) l:Lists(tag mode) o:Open(File mode)  w:Workspace(space mode) b:Bookmark(bookmark mode)   当在buffer mode下使用大写的A添加当前目录到bookmark )，或者使用`,f`打开当前文件夹列表【unite】(最常用，也方便)，事先会在NerdTree找到Bookmark，然后切换到那个目录下，如果想要提交到github也方便使用`:shell`或者使用`:GitStatus`进行事先查看
4. 会使用vim-text-obj,然后使用vim-expand-region的+/-来增大选择区域。
5. 每天都在学习`:h ctrlspace` ,`:h vimwiki`, `:h vim-easy-object`,`:h nerdtree` etc
6. 当觉得当前窗口过小`:res 10` 增加到10行（对于多窗口模式下有用）
7. 在观看代码时候，习惯性的打开TagBar, 事先会进行`ctags -R` 然后`ag -l>cscope.files` ,最后在`set path=f:/cygwin/bin  ; cscope -bq`生成cscope.out
8. 


```

F2: think of ctrlspace


In one workspace(&W : workspace), there're many bookmarks(&b : Bookmark). You can open files(&o: Open) of a bookmark(&b) in one tag(&l Lists, and open another file(&o) of a bookmark(&b) in another tag(&l :Lists). Once you opend one file(&o), actually, you created one buffer(&h Home)


1. Workspace(w  workspace)
2. Bookmark(b  bookmark)
3. Files(&o Open)
4. Tags(&l Lists)
5. Buffers(&h Home)


so, when click F2 in the vim, then o can view file lists, l can view many opened tas, h can view  buffers for opened files. 
```

## 增加vim-expand-selection插件


[vim-expand-region][12] 按照默认进行设置，使用+/-进行增大和减小选择区域


[vim-textobj-user][13] 自定义新的region

```
call textobj#user#plugin('datetime', {
\   'date': {
\     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
\     'select': ['ad', 'id'],
\   },
\   'time': {
\     'pattern': '\<\d\d:\d\d:\d\d\>',
\     'select': ['at', 'it'],
\   },
\ })


call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
  \ non_blank_char_exists_p
  \ ? ['v', head_pos, tail_pos]
  \ : 0
endfunction
```

同时又安装了[vim-textobj-line][14] 所以支持`val vil`
还有就是在使用完`vaw或者viw`之后，还可以使用`)`到句尾，使用`(`跳到句首

## vimwiki的tagbar集成只支持python2.7版本

装3.6版本的python不兼容,已在目录下打包了python，只需要解压添加到路径即可

```

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'/path/to/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }
```

## tag自动生成

[vim-easytags][15] 需要配合[vim-misc][16],进而使用ctags.exe生成tag相关信息(不支持markdown文本编写文件，其他编写[文件][17]支持).
简单使用为`:updatetags`

如何让项目的markdown自动生成tag？？？(原先以为是[vimoutliner][20],后来发现不是，vimoutliner支持otl文件后缀, 也不是[vim-easytags.vim][15]的事情 )
自定义tag生成规则

保存下面内容为.ctags,放入项目根目录即可（但是只支持当前目录), 这和vimwiki按照顺序生成不一样，此种方式是把所有的heading1绑在一起了
```
--langdef=markdown
--langmap=markdown:.mkd
--regex-markdown=/^#[ \t]+(.*)/\1/h,Heading_L1/
--regex-markdown=/^##[ \t]+(.*)/\1/i,Heading_L2/
--regex-markdown=/^###[ \t]+(.*)/\1/k,Heading_L3/


```


[支持Go的ctags][18]
```

--langdef=Go
--langmap=Go:.go
--regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/f,func/
--regex-Go=/var[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/v,var/
--regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/t,type/
```

[ctags支持lua protobuf thrift objective-c][19]
然后重新使用ctags，就会使用该文件中注册语言处理对应文件

```
--langdef=MYLUA
--langmap=MYLUA:.lua
--regex-MYLUA=/^local[ \t]+([a-zA-Z0-9_]+)[ \t]*=[ \t]*\{/\1/v,var/
--regex-MYLUA=/[ \t]*([a-zA-Z0-9_]+)[ \t]*=[ \t]*function[ \t]*\(/\1/f,function/
--regex-MYLUA=/function[ \t]+([a-zA-Z0-9_]+)[\.:]([a-zA-Z0-9_]+)[ \t]*\(/\2/f,function/

--langdef=PROTO
--langmap=PROTO:.proto
--regex-PROTO=/^[ \t]*message[ \t]+([a-zA-Z0-9_\.]+)/\1/m,message/
--regex-PROTO=/^[ \t]*(required|repeated|optional)[ \t]+[a-zA-Z0-9_\.]+[ \t]+([a-zA-Z0-9_]+)[ \t]*=/\2/f,field/

--langdef=thrift
--langmap=thrift:.thrift
--regex-thrift=/^[ \t]*exception[ \t]+([a-zA-Z0-9_]+)/\1/x,exception/
--regex-thrift=/^[ \t]*enum[ \t]+([a-zA-Z0-9_]+)/\1/e,enum/
--regex-thrift=/^[ \t]*struct[ \t]+([a-zA-Z0-9_]+)/\1/s,struct/
--regex-thrift=/^[ \t]*service[ \t]+([a-zA-Z0-9_]+)/\1/v,service/
--regex-thrift=/^[ \t]*[0-9]+:[ \t]+([a-zA-Z0-9_]+)[ \t]+([a-zA-Z0-9_]+)/\2/m,member/
--regex-thrift=/^[ \t]*([a-zA-Z0-9_]+)[ \t]+=/\1/a,value/
--regex-thrift=/^[ \t]*[a-zA-Z0-9_<>]+[ \t]+([a-zA-Z0-9_]+)[ \t]*\(/\1/f,function/

--langdef=objc
--langmap=objc:.m.h
--regex-objc=/^[ \t]*[-+][ \t]*\([^\)]*\)[ \t]*([a-zA-Z0-9_]+)/\1/m,method/
--regex-objc=/^[ \t]*\@property.+[\* \t]+([a-zA-Z0-9_]+)[ \t]*;/\1/p,property/
--regex-objc=/^[ \t]*\@interface[ \t]+([a-zA-Z0-9_]+)/\1/i,interface/
--regex-objc=/^[ \t]*\@implementation[ \t]+([a-zA-Z0-9_]+)/\1/c,class/

```


快速复制.ctags文件到多个目录下

```
for i in `ls `; do cp ace-security/.ctags $i/.ctags ;done;

```

解释： ls列出所有目录和文件（我假设当前只有目录），有文件需要判断一下，这边不做,然护复制即可
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>







Maple's Vim config
==================
blue
I use `vundle` to manage my plugins, which makes my `.vim` directory clean and tidy. If you are new to vim, the following two posts

* [Vim Introduction and Tutorial](http://blog.interlinked.org/tutorials/vim_tutorial.html)
* [Vim plugins I use](http://mirnazim.org/writings/vim-plugins-i-use/)

will be good for you.

#### Most of the time we are writing code so we need:
## Code Completions

Such as completions for variable names and function names(neocomplcache), expanding snippets(snipMate), auto closing brackets/brace/quote(delimitMate) and fast expand expressions to HTML(ZenCoding).

* [neocomplcache](http://github.com/Shougo/neocomplcache) - Ultimate auto completion system for Vim.
* [snipMate](https://github.com/garbas/vim-snipmate) - Plugin for using TextMate-style snippets in Vim.
* [supertab](http://github.com/ervandew/supertab) - Perform all your vim insert mode completions with Tab.
* [ZenCoding](http://github.com/mattn/zencoding-vim) - High speed HTML and CSS coding.
* [delimitMate](http://github.com/Raimondi/delimitMate) - Provides auto-balancing and some expansions for parens, quotes, etc.

### Shortcuts

* `Tab` -> Rotate across the completion list
* `Tab` -> Expand snippets or jump to the next placeholder of snippet
* `Ctrl` + `j` -> Call zen-coding expansion on html tags

### Dependencies

Compile Vim with `--enable-pythoninterp` and `--enable-rubyinterp` to enable powerful syntax completion supplied by neocomplcache.

``` bash
brew install macvim --override-system-vim  # OS X
yaourt -S gvim                             # ArchLinux
sudo apt-get install vim-gtk               # Ubuntu
```

### Tutorial

``` vim
:help zencoding
```

[Movie teaching zencoding.vim](http://mattn.github.com/zencoding-vim/)

### Screenshots

![Completions](https://raw.github.com/humiaozuzu/dot-vimrc/master/screenshots/completions.gif)
![Snippets](https://raw.github.com/humiaozuzu/dot-vimrc/master/screenshots/snippets.gif)

#### Sometimes we need to jump to previous positions to copy/paste or do some fixes:
## Fast navigation

* [matchit](http://github.com/tsaleh/vim-matchit) - Extended % matching for HTML, LaTeX, and many other languages.
* [EasyMotion](https://github.com/Lokaltog/vim-easymotion) - Vim motions on speed!

### Tutorial

``` vim
:help easymotion
```

### Shortcuts

* `%` -> Jump between brackets and html/xml tags
* `<leader>` + `w` -> Beginning of the word.
* `<leader>` + `f` + `{char}` -> Find {char} to the right.

#### Doing fixes should be as fast as possible!
## Fast editing

* [surround](http://github.com/tpope/vim-surround) - Easily delete, change and add such surroundings in pairs.
* [nerdcommenter](http://github.com/scrooloose/nerdcommenter) - Easy commenting of code for many filetypes.
* [Gundo](https://github.com/sjl/gundo.vim/) - visualize your Vim undo tree.
* [tabular](https://github.com/godlygeek/tabular) - Vim script for text filtering and alignment.
* [IndentGuides](https://github.com/nathanaelkane/vim-indent-guides) - A Vim plugin for visually displaying indent levels in code.

### Tutorial

``` vim
:help text-objexts
:help surround
:help tabular
```

### Shortcuts

* `%` -> Jump between brackets and html/xml tags
* `<leader>` + `c` + `<space>` -> Toggle comment
* `F3` -> Toggle Gundo viewer
* `F4` -> Toggle Indent Guides

## IDE features

* [nerdtree](http://github.com/scrooloose/nerdtree) - A tree explorer plugin for navigating the filesystem.
* [tabbar](http://github.com/humiaozuzu/TabBar) -  Add tab bar and quickt tab switch with alt+1~9.
* [tagbar](http://github.com/majutsushi/tagbar) - Displays the tags of the current file in a sidebar.
* [ack-vim](http://github.com/mileszs/ack.vim) - Front for the Perl module App::Ack.
* [ctrlp](https://github.com/kien/ctrlp.vim) - Fuzzy file, buffer, mru and tag finder.
* [powerline](https://github.com/Lokaltog/vim-powerline) - The ultimate vim statusline utility.
* [fugitive](https://github.com/tpope/vim-fugitive/) - a Git wrapper so awesome, it should be illegal.
* [syntastic](https://github.com/scrooloose/syntastic) - Syntax checking hacks for vim.

### Dependencie

```bash
yaourt -S ack ctags                  # ArchLinux
sudo apt-get install ack-grep ctags  # Ubuntu
brew install ack ctags               # OS X
```

For syntax check tools:

Languages    | Lint Tools    | Install guide
------------ | ------------- | ------------
C            | gcc           | built-in
CPP          | g++           | built-in
CoffeeScript | coffee        | `npm install -g coffeelint`
CSS          | csslint       | `npm install -g csslint`
Erlang       | escript       | built-in
Go           | go            | built-in
Haml         | haml          | built-in
Haskell      | ghc-mod       | `cabal install ghc-mod`
HTML         | tidy          | built-in
Java         | javac         | built-in
Javascript   | jshint        | `npm install -g jshint`
Json         | jsonlint      | `npm install -g jsonlint`
Less         | lessc         | built-in
Lisp         | clisp         | built-in
Lua          | luac          | built-in
Perl         | perl          | built-in
PHP          | php           | built-in
Puppet       | puppet        | built-in
Python       | pyflakes      | `sudo pip install pyflakes`
Ruby         | ruby          | built-in
Scala        | scala         | built-in
Sass         | sass          | built-in
Scss         | scss/compass  | `gem install compass`
XML          | xmllint       | built-in
YAML         | js-yaml       | `npm install -g js-yaml`

### Shortcuts
* `F5` -> Toggle Nerd-Tree file viewer
* `F6` -> Toggle tagbar
* `Ctrl` + `p` -> Toggle ctrlp
* `Alt` + `1~9` -> Switch between multiple buffers
* `Ctrl` + `h/j/k/l` -> Moving between spilt windows
* `:Ack` or `<leader>` + `a` -> Toggle Ack searching

### Screenshots

![Vim IDE 1](https://raw.github.com/humiaozuzu/dot-vimrc/master/screenshots/vim.jpg)
![Vim IDE 2](https://raw.github.com/humiaozuzu/dot-vimrc/master/screenshots/vim2.jpg)

## Other Utils

* [fcitx-status](https://github.com/humiaozuzu/fcitx-status) - automatic change status of fcitx in vim.
* [togglemouse](https://github.com/nvie/vim-togglemouse/) - Toggles the mouse focus between Vim and your terminal emulator, allowing terminal emulator mouse commands, like copy/paste.

### Shortcuts

* `F12` -> Toggle Mouse

## Better syntax/indent for language enhancement

- Server
   - php
   - go
   - rails
   - jinja
   - jade
- Web
   - html5
   - haml
   - javascript
   - jquery
   - coffeescript
   - less
   - stylus
   - handlebar
- Markup language
   - markdown
   - textile
- FPs
   - racket
   - clojure
   - scale
 

## Themes

* [blackboard](https://github.com/rickharris/vim-blackboard) - Textmate's Blackboard theme for vim (with iTerm2 theme)
* [molokai](https://github.com/rickharris/vim-monokai) - A port of the monokai scheme for TextMate
* [solarized](https://github.com/altercation/vim-colors-solarized) - precision colorscheme for the vim text editor
* [vividchalk](https://github.com/tpope/vim-vividchalk) - colorscheme based on the Vibrant Ink theme for TextMate
* [distinguished](https://github.com/Lokaltog/vim-distinguished) - A dark vim color scheme for 256-color terminals.
* [tomorrow](https://github.com/chriskempson/vim-tomorrow-theme) - Tomorrow Theme for Vim
* [fisa](https://github.com/fisadev/fisa-vim-colorscheme) - soft color scheme for terminals with 256 colors
Clone in Mac

## Additional functions

1. File encoding auto detection
* Hightlight current line and column
* Automatically jump to the last edited location
* `:w`/`:wq` error correction
* Remove trailing white space(run `:FixWhitespace` in vim)
* Code folding is disabled, enable it as you wish
* `w!!` to write if you forget add sudo
* Indent style:
   * JavaScript - Use soft-tabs with a two space indent(According to this [Post](http://atroche.org/post/30994290348/javascript-indentation)).
   * HTML/CSS - Use soft-tabs with a two space indent(According to Google and Github's HTML/CSS style guide, just Google it).
   * PHP - Use soft-tabs with a two space indent(According to [Apache PHP Style Guide](http://svn.apache.org/repos/asf/shindig/trunk/php/docs/style-guide.html)).
   * Python - Use soft-tabs with a four space indent([PEP8](http://www.python.org/dev/peps/pep-0008/)).

## Installation

1. Backup your old vim configuration files:

        mv ~/.vim ~/.vim.orig
        mv ~/.vimrc ~/.vimrc.orig

2. Clone and install this repo:

        git clone git://github.com/humiaozuzu/dot-vimrc.git ~/.vim
        ln -s ~/.vim/vimrc ~/.vimrc

3. Setup `Vundle`:

        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

4. Install bundles. Launch vim(ignore the errors and they will disappear after installing needed plugins)and run:

        :BundleInstall

Thst's it!

For installation on Windows, please refer to this post: http://blog.yoxyue.com/post/gvim-on-win7 (Thanks to [yoxyue](https://github.com/yoxyue))

## How to manage this vimrc?

All plugins are listed in file `bundles.vim` with detailed comments, just add plugins as you like.

1. `:BundleClean` to clean up unused plugins
2. `:BundleInstall` to install newly added plugins
3. `:BundleInstall!` to upgrade all plugins

Other configurations are also well organized in vimrc.

## Known issues

* Compeletions are not well supported for statically typed languages(c/c++)
* Snippets are not shown in completions popups
* May has some conflicts with GVIM


[1]:http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/
[2]:http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/
[3]:https://andrew.stwrt.ca/posts/vim-ctags/
[4]:https://github.com/szw/vim-tags
[5]:https://github.com/universal-ctags/ctags-win32/releases
[6]:https://github.com/universal-ctags/ctags
[7]:https://github.com/Shougo/vimproc.vim/releases
[8]:http://blog.csdn.net/augusdi/article/details/39974259
[9]:https://blog.easwy.com/archives/cscope_sort_option_on_windows/ 
[10]:https://blog.easwy.com/archives/advanced-vim-skills-cscope/ 
[11]:http://jueqingsizhe66.github.io/blog/2017/08/13/what-vim-teaches-you/ 
[12]:https://github.com/terryma/vim-expand-region 
[13]:https://github.com/kana/vim-textobj-user 
[14]:https://github.com/kana/vim-textobj-line 
[15]:https://github.com/xolox/vim-easytags 
[16]:https://github.com/xolox/vim-misc 
[17]:http://ctags.sourceforge.net/languages.html 
[18]:http://noyesno.net/page/ctags/support-go.html 
[19]:http://blog.csdn.net/jncpp/article/details/42691421 
[20]:https://github.com/vimoutliner/vimoutliner 
