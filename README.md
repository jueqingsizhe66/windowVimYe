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

fzf和ag其实都是类似的东西。

## I. \<leader\>q: search context in files with ag, let you fly

十分有用的功能,q(查找光标下的单词) 空格斜杠查找项目中的单词

```
" --- type to search the word in all files in the current dir
nmap <leader>q :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag


```

我居然忘了z/ 特别有用(当然/也是可以有作用

``` vim

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)


在同一个文件下使用`,w` `,b`进行快速定位 easymotion

```

同时也改进了ctrlspace的设置

```
if executable("ag")
        let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
```

因为安装了ag.vim所以可以按照如下配置方式

``` vim

" --- type  ,q to search the word in all files in the current dir
nmap <leader>q :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag



```

## II. \<space\>\<space\>: search file in project directory with unite file_rec, let you fly too
Stackoverflow , author of Shoudo(去查看[vim-as-IDE][2])

without vimproc(for async ,can be used in linux, had better not in windows)
```
In Windows, you should not use file_rec/async source. It is too slow and not easy to use. You should use file_rec source instead.
```

注意在windows使用起来最好使用[vimproc.dll][7]放在c:/windows/system32/底下即可.

所以你现在就可以在项目文件夹使用\<Space\> \<space\>来打开搜索文件夹目录搜索文件，可快可爽的感觉。


## III. :Gdiff : fugitive Gdiff eye your difference of files

wow, good, let you what is different with the latest version!!

Gread, let you reset the changes from the latest commit version(东西没有了额！！)
Gwrite, stash what the changes.(暂存起来)

:set nolist 不显示右箭头。

[gv.vim][21] 不错的快捷的版本显示工具（需要[fugitive][22]的支持！)

![gv][23]

配合上`GitPull` 可以不断的提取更新，然后观看改进的地方，不错的学习方式！！！
![gitpull][24]

## IV. vim-tags

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


## V. vim-cscope


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


## VI. 当前vim工作流程

1. 打开文件，编写(涉及到git提交问题，一般选择emacs的magit形式，进行工作，就比如现在我正在emacs编写)
2. 需要记录知识，概念，打开calendar(我已经在.vimrc)配置好，所以可以直接使用`,ca`打开calendar，调到当前日期写日记,当然直接打开当前日子`,wt`
然后有可能使用`xdate`产生日期，很有意思的是enter一下即可产生链接(vimwiki做得不错），然后还可以使用backspace回到`,wi` diary总管理界面，可不舒爽
的一个编辑过程，两个键方便写来读去，很是方便 ,进一步参考[what vim teatches you][11]
3. 双空格进行搜索【unite】，`,a`进行查找【unite+ag】，`,q`查找光标下单词【unite+ag】，使用`F2`打开ctrlspace文件管理器(h:Home(Buffer mode) l:Lists(tag mode) o:Open(File mode)  w:Workspace(space mode) b:Bookmark(bookmark mode)   当在buffer mode下使用大写的A添加当前目录到bookmark )，
![ctrlspace][26]
或者使用`,f`打开当前文件夹列表【unite】(最常用，也方便)，事先会在NerdTree找到Bookmark(A可以toggle最大化nerdtree窗口，`:bookmark`添加当前项目到nerdtree bookmark系列下面!注意只能在NerdTree窗口下才能执行`:bookmark`命令。
然后切换到那个目录下，如果想要提交到github也方便使用`:shell`或者使用`:GitStatus`进行事先查看
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

## VII. 增加vim-expand-selection插件


[vim-expand-region][12] 按照默认进行设置，使用+/-进行增大和减小选择区域


[vim-textobj-user][13] 自定义新的region

```
call textobj#user#plugin('datetime', {
\   'markdate': {
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

## 第8. vimwiki的tagbar集成只支持python2.7版本

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


一些有用的编辑技巧(经验）

一、vih vah 可以选择两个heading之间的信息

```
ah                      A section segment (the area between two consecutive
                        headings) including trailing empty lines.
ih                      A section segment without trailing empty lines.

```
二、 list的编写

list item中赋予了gl gL与一个强大函数功能[也可以算是list的一个技能]，通过它结合后缀字符从而对list item进行控制

gL* gL# gLi gLI gL- gL+ gLa gLA 

gll 进行右移， 不同于Tab的是，gll会计算item项计算，判断是属于第几个item
很重要的一点glh,gLh代表是左移。(Ctrl+@ toggle checkbox)

``` vim
nmap <C-@> <Plug>VimwikiToggleListItem
vmap <C-@> <Plug>VimwikiToggleListItem

```

三、在vimwiki使用`:VimwikiTable 2 10` 生成2个cols 10行记录的表格， 然后可以使用

```
    :VimwikiTable cols rows
    Create a table with the given cols and rows

    :VimwikiTable cols
    Create a table with the given cols and 2 rows


```


1. vic  vac  选择一列
2. vi\ va\ 选择一个cell
3. gqq或者gww可以强制刷新Table 

```
a\                      A cell in a table.
i\                      An inner cell in a table.
ac                      A column in a table.
ic                      An inner column in a table.

al                      A list item plus its children.
il                      A single list item.


```

还有一个比较厉害的`Alt left` 和`Alt right`[小技巧方便操作] 进行切换


```
*:VimwikiTableMoveColumnLeft* , *:VimwikiTableMoveColumnRight*
    Move current column to the left or to the right:

    Commands are mapped to <A-Left> and <A-Right> respectively.



```
四、Ctrl-Enter 生成垂直的new wiki， shift+enter水平的new wiki（在list的item模式 shift+enter切换item和文本模式
直接Enter不产生新的界面，当前窗口编辑新wiki

五、内部链接



比较简单文件链接

```
  [[file:/home/somebody/a/b/c/music.mp3]]

```

### 基本原理
Every header, tag, and bold text can be used as an anchor.  To jump to it, use
a wikilink of the form
```
  [[file#anchor]]


```

### 跳转原理

```

For example, consider the following file "Todo.wiki": >
  = My tasks =
  :todo-lists:
    == Home ==
        - [ ] bathe my dog
    == Work ==
        - [ ] beg for *pay rise*
    == Knitting club ==
        === Knitting projects ===
            - [ ] a *funny pig*
            - [ ] a *scary dog*

Then, to jump from your index.wiki directly to your knitting projects, use: >
  [[Todo#Knitting projects]]

Or, to jump to an individual project, use this link: >
  [[Todo#funny pig]]

Or, to jump to a tag, use this link: >
  [[Todo#todo-lists]]

If there are multiple instances of an anchor, you can use the long form which
consists of the complete header hierarchy, separated by '#': >
 [[Todo#My tasks#Knitting club#Knitting projects#scary dog]]

If you don't feel like typing the whole stuff, type just [[Todo# and then
|i_CTRL-X_CTRL-O| to start the omni completion of anchors.

For jumping inside a single file, you can omit the file in the link: >
  [[#pay rise]]


```

在双中括号内部头使用#然后跟上内部标签，当然在＃前面也可以加上文件名，这边的内部标签包括

1. header
2. 粗体(bolder)
3. 双冒号构成的标记(标准形式)(tag)

```
A tag is a sequence of non-space characters between two colons: >
        :tag-example:
It is allowed to concatenate multiple tags in one line: >
        :tag-one:tag-two:
<
If placed in the first two lines of a file, the whole file is tagged.  If
placed under a header, within the 2 lines below it, the header is then tagged
with this tag, and the tag search commands will jump to this specific header.
Otherwise, the tag stands of its own and the search command jumps directly to
it.

<

```

很重要关于寻找tag的方法

注意简单技能：当书写到#时候，快捷键`ctrl-x ctrl-o`[小技巧，改变你的方式],弹出所有的tags
```

Tags-related commands and options:

   * |:VimwikiRebuildTags|
   * |:VimwikiGenerateTags|
   * |:VimwikiSearchTags|
   * |vimwiki-option-auto_tags|



```

六、 目录生成

有时候需要生成目录，方便观察，使用`:VimwikiTOC`,这里TOC表示Tabel of content
还有注意一点，有可能vimwiki会自动帮您生成折叠(fold)，打开使用`zr`,关闭使用`zm`,更进一步`:help vimwiki`

## 第9. tag自动生成

[vim-easytags][15] 需要配合[vim-misc][16],进而使用ctags.exe生成tag相关信息(不支持markdown文本编写文件，其他编写[文件][17]支持).
简单使用为`:updatetags`

如何让项目的markdown自动生成tag？？？(原先以为是[vimoutliner][20],后来发现不是，vimoutliner支持otl文件后缀, 也不是[vim-easytags.vim][15]的事情 )
自定义tag生成规则

保存下面内容为.ctags[在README.md目录下],放入项目根目录即可（但是只支持当前目录), 这和vimwiki按照顺序生成不一样，此种方式是把所有的heading1绑在一起了
```
--langdef=markdown
--langmap=markdown:.mkd
--regex-markdown=/^#[ \t]+(.*)/\1/h,Heading_L1/
--regex-markdown=/^##[ \t]+(.*)/\1/i,Heading_L2/
--regex-markdown=/^###[ \t]+(.*)/\1/k,Heading_L3/


```

![markdown][25]


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

--regex-objc=/^[ \t]*\@interface[ \t]+([a-zA-Z0-9_]+)/\1/i,interface/
--regex-objc=/^[ \t]*\@implementation[ \t]+([a-zA-Z0-9_]+)/\1/c,class/

```


快速复制.ctags文件到多个目录下

```
for i in `ls `; do cp ace-security/.ctags $i/.ctags ;done;

```

解释： ls列出所有目录和文件（我假设当前只有目录），有文件需要判断一下，这边不做,然护复制即可



# Part2. 开始新篇章

## 一些小技巧改变你的生活


1. `,1  ,2 ,3` 分别打开第一个标签、第二个、第三个【原先使用1gt 2gt2 3gt,  减少了你的手指按键时间, 当然两者思路不同，早先用的是标签信息先行，我就知道我要哪个
             而新的方式则是local leader先行，然后才确定具体哪个标签】

```
你可以用如下命令取得所有的标记的列表：
:marks
你会注意到有一些特殊的标记，包括：

 ' 跳转前的位置( <2018-06-08 16:37> 输入两次'跳转回上一次访问位置

 " 最后编辑的位置

 [ 最后修改的位置的开头

 ] 最后修改的位置的结尾

```

2. `:Startify` 新增加了 `{'r': '~/.vim/README.md'}`, 快速打开文档，记录对vim新的认识

![startify][27]

3. `V` 大写的V，可视化当前行，对于演示的时候特别有效，表示我现在只是针对当前行进行操作，特别具有目的性。

4. `,cp  ,cf ,cd`  复制当前文件的全路径， 当前文件文件名，当前文件的目录

5. `m[A-Z]` 阔文件间进行标记，对于大型项目有用，使用`单反引号[A-Z]` 进行跳转, 对于`m[a-z]`只支持文件内跳转。

6. `,wr ,wd` 针对于wiki文件，可以重命名当前wiki链接，也可以删除该链接。

7. `,l`，针对于当前文件搜索特定内容，类似于emacs的 Ivy-swipe的作用，搜索功能强大

8. `,f` 打开vimproc文件夹管理界面， `K`新建一个文件夹   `N` 新建一个文件
    选择功能 : 使用空格
    命令： m  移动文件
           d  删除文件
           r  重命名当前文件[单个]
           ~  HOME目录(windows下的用户目录)
           \  磁盘根目录
           &  ampersand 项目目录(默认是.git .hg .svn等)
           L  所有磁盘分区(功能还是挺强大的，方便切换，当然最好还是在startify中添加bookmark比较方便些)
9. `:map` 知道你的vim编辑器的所有快捷键(体现持续学习的过程)。

10. `xdate` 自己写的函数，迅速插入当前日期 

    `iabbrev xdate <c-r>=strftime("%Y-%m-%d")<cr>`

    然后又定制了speeddate插件，使用`Ctrl+A` 表示增加当前日期， 使用`Ctrl+X` 表示减少当前日期

11. 编译perl单文件
```
Set makeprg=perl

然后就可以打开vim *.pl
在命令行模式下执行 :make %
%号指代的旧时的当前文件
```

12. what is path?

`:h path`

```
This is a list of directories which will be searched when using the
|gf|, [f, ]f, ^Wf, |:find|, |:sfind|, |:tabfind| and other commands,
provided that the file being searched for has a relative path (not
starting with "/", "./" or "../").  The directories in the 'path'
option may be relative or absolute.
- Use commas to separate directory names
:set path=.,/usr/local/include,/usr/include

```

2018-04-19 

13. vimwiki tab技巧

要记得vimfiles的概念


`:tabname:` 创建一个名为tabname的tab

`[[#tabname]]` 调用tabname的tab

如果在打开gvim持续出现`git -c color.status=false...`, 那么直接使用`Ctrl +C`关闭该窗口即可

14. goyo.vim and limelight.vim专注写作

很重要一点当前我用的colorscheme是[srcery][35]
[goyo.vim][28] and [limeligh.vim][29]

先执行`:goyo`然后也可以调整窗口大小`:Goyo100`

紧接着`:LimeLight0.8`比较合适些(limelight适宜任何文件) <2018-06-05 01:00>


![limelight][30]


``` vim
" === Goyo
" changing from the default 80 to accomodate for UndoTree panel
let g:goyo_width = 104

function! s:goyo_enter()
  if has('gui_running')
   ""   :call FullScreen()
   let w:full_screen=1
""   set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight 0.8
  NERDTreeToggle
endfunction

function! s:goyo_leave()
  if has('gui_running')
   let w:full_screen=0
""    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
  NERDTreeToggle
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap <Leader>h :Goyo<CR>
xmap <Leader>h :Goyo<CR>

```


15. honza/vim-snippets  类似于emacs的yasnippet

[honza/vim-snippets][31]

同时最好安装上[garbas的vim-snipmate][32],通过它编写c等编程语言很方便，比如输入for然后tab键即可补全for循环。
以及两个辅助配件[vim-addon-mw-utils][33]和[tlib-vim][34]


没打开一个.vimrc,都会查找~/vimfiles/templates文件夹对应的vim.templates。类似的，每打开一个perl文件，都会查找
~/.vimfiles/templates底下的perl.templates

--------



依旧奋战在vim的持续学习中……

16. 类似于ctrlspace的ctrlp文件快速导航

通过[bigvim][36]学习，认识到我的配置中还加入CtrlP(按住ESC退出)

`:CtrlP`(Ctrl-P 为快捷键)

`:CtrlPMRUFiles`  相当于mru功能，most recently used(不用打开Startify了)---->设置快捷键为F2

`:CtrlPBuffers`  查找当前tag的buffers------>设置快捷键为F1(终于把默认的F1调用help.txt改了快捷键)

`:CtrlPTags` 查找所有Tag，所以真是和CtrlSpace冲突了

并由此抛弃了Ctrl-Space做了一次大变动，把F2投影成为`:CtrlP`(因为比较发现他的速度比较快. 功能和CtrlSpace类似)
默认现在调用方式是`Ctrl-P`

查找函数得加上CtrlP的插件CtrlPFunky

`,fu` 执行`:CtrlPFunky`,列出当前文件的所有函数

`,fU` 执行`:CtrlPFunky`. expand('<cword>')<Cr>, 定位到指定函数中

17. vim-maximizer 最大化当前窗口

'szw/vim-maximizer'在多窗口阅读时候特别有用！！快捷键为F4

18.  vim-MatchTagAlways

也是特别方便，特别是观看html、xml文档等成对tag组成的标识文件时候！！

19. 整理了myplugins

注释掉不常用，需要的时候关掉注释即可！！简化你的vim
下图为被注释掉的语言，

![delete][37]

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

* [Vim Introduction and Tutorial](http://blog.interlinked.org/tutorials/vim_tutorial.html)
* [Vim plugins I use](http://mirnazim.org/writings/vim-plugins-i-use/)

will be good for you.

#### Most of the time we are writing code so we need:
## Code Completions

Such as completions for variable names and function names(neocomplcache), expanding snippets(snipMate), auto closing brackets/brace/quote(delimitMate) and fast expand expressions to HTML(ZenCoding).

* [neocomplcache](http://github.com/Shougo/neocomplcache) - Ultimate auto completion system for Vim.
* [snipMate](https://github.com/garbas/vim-snipmate) - Plugin for using TextMate-style snippets in Vim.
* [supertab](http://github.com/ervandew/supertab) - Perform all your vim insert mode completions with Tab.
* [delimitMate](http://github.com/Raimondi/delimitMate) - Provides auto-balancing and some expansions for parens, quotes, etc.


## Fast navigation

* [matchit](http://github.com/tsaleh/vim-matchit) - Extended % matching for HTML, LaTeX, and many other languages.
* [EasyMotion](https://github.com/Lokaltog/vim-easymotion) - Vim motions on speed!

## How to manage this vimrc?

All plugins are listed in file `plug.vim` with detailed comments, just add plugins as you like.

1. `:PlugClean` to clean up unused plugins
3. `:PlugInstall!` to upgrade all plugins

Other configurations are also well organized in vimrc.

2. `:PlugInstall` to install newly added plugins
``` vim
nnoremap g<LocalLeader> :call setline(line('.'),substitute(getline('.'),'\\','\/','g'))<CR>
nnoremap gd<LocalLeader> :call setline(line('.'),substitute(getline('.'),'\\','\\\\','g'))<CR>

也就是g\(gd\表示把windows的单斜杠变为双斜杠)


```

注意windows下直接复制过来的链接不好使，得转化一下 `K:\IntellijHome\elasticsearch-6.1.2\bin `
变为`K:/IntellijHome/elasticsearch-6.1.2/bin `

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
[21]: https://github.com/junegunn/gv.vim
[22]: https://github.com/tpope/vim-fugitive
[23]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/gv.png
[24]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/gitpull.png
[25]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/markdown.png
[26]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/ctrlspace.png
[27]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/startify.png
[28]: https://github.com/junegunn/goyo.vim
[29]: https://github.com/junegunn/limelight.vim
[30]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/limelight.png
[31]: https://github.com/honza/vim-snippets
[32]: https://github.com/garbas/vim-snipmate
[33]: https://github.com/MarcWeber/vim-addon-mw-utils.git
[34]: https://github.com/tomtom/tlib_vim.git
[35]:https://github.com/roosta/vim-srcery 
[36]:https://github.com/ruanyl/bigvim 
[37]: https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/delete.png
