# 主要目的
快速编辑文件

[learn-vim-progressively][1]
[vim-as-IDE][2]

<font color="red">sorry for bundle/文件夹没有上传</font>

如果您依然想用，那么只好忽略警告,然后`Plug Install`一下即可

## 安装需求

```
1. 记得更改ag.exe,perl.exe,es.exe,git.exe 哈，在.vimrc的第943行，搜索一下即可
并且把.vim目录下的ag.exe添加到path路径下，这样你就可以愉快的`,a`,命令行显示`:Ack everything`

2. 安装ctags(ubuntu: apt-get install exuberant-ctags)和cscope(apt-get install cscope)
```

fzf和ag其实都是类似的东西。

## I. \<leader\>q: search context in files with ag, let you fly

十分有用的功能,q(查找光标下的单词) 空格斜杠查找项目中的单词

```
" --- type to search the word in all files in the current dir
nmap <leader>q :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag


```

但是ag也不见得特别准，有时候还是得在cmd窗口下查找，才最靠谱(因为有可能受限于你的vimrc配置)。

我居然忘了z/ 特别有用(当然/也是可以有作用


``` vim

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)


在同一个文件下使用`,w` `,b`进行快速定位 easymotion

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

1. 使用`ag -l > cscope.files` 生成该文件，（默认cscope只处理` *.c *.lex *.yal文件，不处理*.java *.c++`等），所以需要手动搜索一下
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



### 文件外操作:

1. 打开文件，编写(涉及到git提交问题，一般选择emacs的magit形式，进行工作，就比如现在我正在emacs编写)
2. 使用`F2` 打开ctrlp最经常打开的文件列表，使用Ctrl-P打开你当前目录下的文件)，或者使用`,f`打开当前文件夹列表【unite】(最常用，也方便)，
    事先会在NerdTree找到Bookmark(A可以toggle最大化nerdtree窗口，`:bookmark`添加当前项目到nerdtree bookmark系列下面!
    注意只能在NerdTree窗口下才能执行`:bookmark`命令。
    然后切换到那个目录下，如果想要提交到github也方便使用`:shell`或者使用`:GitStatus`进行事先查看
3. 使用`:Startify`来打开文件管理界面,切换到常用文件列表
4. 需要记录知识，概念，打开calendar(我已经在.vimrc)配置好，所以可以直接使用`,ca`打开calendar，调到当前日期写日记,当然直接打开当前日子`,wt`
然后有可能使用`xdate`产生日期，很有意思的是enter一下即可产生链接(vimwiki做得不错），然后还可以使用backspace回到`,wi` diary总管理界面，可不舒爽
的一个编辑过程，两个键方便写来读去，很是方便 ,进一步参考[what vim teatches you][11]. 在编辑vimwiki文件时候，list项目时候使用`glX` 添加checkbox，
使用`Ctrl-Shift-@`toggle checkbox选项!
5. 双空格进行搜索【unite,建议不用】
6. 有时候经常需要拷贝路径+文件名，使用`<leader>cp`搞定问题，或者拷贝目录`<leader>cd`太方便了，特别是编写脚本 2018-08-23 的确有用!赞！！！TotalCommander也有类似的功能!

### 文件内操作:
1. 使用<leader>l 打开文件内搜索
2. 在观看代码时候，习惯性的打开TagBar, 事先会进行`ctags -R` 然后`ag -l>cscope.files` ,最后在`set path=f:/cygwin/bin  ; cscope -bq`生成cscope.out; `,a`进行查找【unite+ag】，`,q`查找光标下单词【unite+ag】，
3. 使用vim-text-obj,然后使用vim-expand-region的+/-来增大选择区域, 最近安装了[vim-after-object][51]也是挺好用的
4. 时常学习`:h vimwiki`, `:h vim-easy-object`,`:h nerdtree` etc
5. 当觉得当前窗口过小`:res 10` 增加到10行（对于多窗口模式下有用）


```
虽然ctrlspace被我从vim配置中移除了，但是他整合的几个概念还是有意思

 think of ctrlspace


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


`gL* gL# gLi gLI gL- gL+ gLa gLA `

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

的确有用! 2018-08-23 

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

[vim-easytags][15] 需要配合[vim-misc][15],进而使用ctags.exe生成tag相关信息(不支持markdown文本编写文件，其他编写[文件][17]支持).
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

[ctags scala][46]


# Part2. 开始新篇章

## 一些小技巧改变你的生活


### 1. `,1  ,2 ,3` 分别打开第一个标签、第二个、第三个【原先使用1gt 2gt2 3gt,  减少了你的手指按键时间, 当然两者思路不同，早先用的是标签信息先行，我就知道我要哪个
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

### 2. `:Startify` 新增加了 `{'r': '~/.vim/README.md'}`, 快速打开文档，记录对vim新的认识(再输入冒号时候 Shift+;不必要 只要分号键即可！也就是说在可视模式下输入分号等效于冒号)

![startify][27]

3. `V` 大写的V，可视化当前行，对于演示的时候特别有效，表示我现在只是针对当前行进行操作，特别具有目的性。

4. `,cp  ,cf ,cd`  复制当前文件的全路径， 当前文件文件名，当前文件的目录, 2018-09-06 特别有用，经常需要基于当前文件获取当前文件夹名字

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

插入日期的时候相当于产生了对应的日期wiki！这样方便写wiki!
11. 编译perl单文件
```
Set makeprg=perl

然后就可以打开vim *.pl
在命令行模式下执行 :make %
%号指代的旧时的当前文件
```

### 12. what is path?

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

### 13. vimwiki tab技巧

```
Place your cursor on Tasks and press Enter to create a link. Once pressed, Tasks will become [[Tasks]] -- a Vimwiki link.
Press Enter again to open it. Edit the file, save it, and then press Backspace to jump back to your index.
```
要记得vimfiles的概念


`:tabname:` 创建一个名为tabname的tab

`[[#tabname]]` 调用tabname的tab

如果在打开gvim持续出现`git -c color.status=false...`, 那么直接使用`Ctrl +C`关闭该窗口即可

### 14. goyo.vim and limelight.vim专注写作

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


### 15. honza/vim-snippets  类似于emacs的yasnippet

[honza/vim-snippets][31]

同时最好安装上[garbas的vim-snipmate][32],通过它编写c等编程语言很方便，比如输入for然后tab键即可补全for循环。
以及两个辅助配件[vim-addon-mw-utils][33]和[tlib-vim][34]


没打开一个.vimrc,都会查找~/vimfiles/templates文件夹对应的vim.templates。类似的，每打开一个perl文件，都会查找
~/.vimfiles/templates底下的perl.templates

--------



依旧奋战在vim的持续学习中……

### 16. 类似于ctrlspace的ctrlp文件快速导航

通过[bigvim][36]学习，认识到我的配置中还加入CtrlP(按住ESC退出)

`:CtrlP`(Ctrl-P 为快捷键) 2018-06-24 终于想起了这个快捷键，现在F1 F2都只是打开的文件，而无法搜索当前项目文件夹内的所有文件。而且还有一个制约点，
    即使现在`pwd`显示为项目路径，还得打开项目路径下的文件下，ctrlp才会查找项目文件夹内容！速度快！
    当然在linux底下最后试试fzf(go语言开发，ctrlp通过vimscript编写)，虽然他可能更快一写
    特别大量的文件集在考虑使用fzf
        fzf 的原因是有几十万个文件或更多的时候 ui 几乎没有明显卡顿，LeaderF 在这方面好像还不够，刚刚试了下有点小卡，当然已经比 ctrlp 好很多了。 


CtrlP和ag也可以结合起来使用，[ctrlP-ag][38]

``` vim
   - 由于使用外部工具ag扫描必须开启g:ctrlp_user_command选项，而开启这个选项会带来一些副作用，
比如g:ctrlp_show_hidden和g:ctrlp_custom_ignore'会失效 
，g:ctrlp_show_hidden用于搜索隐藏的文件和目录， g:ctrlp_custom_ignore用于自定义忽略的文件，
如果有这些方面的需求的话就需要权衡一下了。
   - 另外还有一个缺点，ag需要index阶段，所以会影响你的使用，就好像CtrlSpace一样，结合Ag，都得indexing过程。

```

为了提高ctrlp搜索的命中率(洗清，数据清理, 正则匹配)，于是做了一些配置(文件名的配置的确是有用的！不然如果按照全路径有很多不符合逻辑的出现)

```
"默认使用全路径搜索，置1后按文件名搜索，准确率会有所提高，可以用<C-d>进行切换
let g:ctrlp_by_filename = 1
"默认不使用正则表达式，置1改为默认使用正则表达式，可以用<C-r>进行切换
"调用ag进行搜索提升速度，同时不使用缓存文件
let g:ctrlp_regexp = 0

```

`:CtrlPMRUFiles`  相当于mru功能，most recently used(不用打开Startify了)---->设置快捷键为F2

`:CtrlPBuffers`  查找当前tag的buffers------>设置快捷键为F1(终于把默认的F1调用help.txt改了快捷键)

`:CtrlPTags` 查找所有Tag，所以真是和CtrlSpace冲突了

并由此抛弃了Ctrl-Space做了一次大变动，把F2投影成为`:CtrlP`(因为比较发现他的速度比较快. 功能和CtrlSpace类似)
默认现在调用方式是`Ctrl-P`

查找函数得加上CtrlP的插件CtrlPFunky

`,fu` 执行`:CtrlPFunky`,列出当前文件的所有函数

`,fU` 执行`:CtrlPFunky`. expand('<cword>')<Cr>, 定位到指定函数中

### 17. vim-maximizer 最大化当前窗口

'szw/vim-maximizer'在多窗口阅读时候特别有用！！快捷键为F3(F4修改为sketch on)

18.  vim-MatchTagAlways

也是特别方便，特别是观看html、xml文档等成对tag组成的标识文件时候！！

### 19. 整理myplugins

注释掉不常用，需要的时候关掉注释即可！！简化你的vim
下图为被注释掉的语言，

![delete][37]

### 20. 有趣的阅读注释(只针对于wiki后缀的文件)


有时候你会想着在你的wiki系统中，加入你特殊的注释、小结，这很有必要，是对你的阅读的一段回顾和提升。为此，你选择下面的独特风格，
这样也方便通过ag.exe进行查找所有包含Brief Summary的内容.


``` vim
    nmap <F8> O<ESC>O<ESC>jO- Brief Summary(by yzl):<CR><ESC>0d$i{{{<CR><Tab><CR><ESC>v0xk$a1. so what?

```

说明:
1. 在visual模式下，绑定到快捷键F8
2. O`<ESC>`O`<ESC>`jO-  O在上一行进入input 模式，`<ESC>`进入visual，再O上一行进入，`<ESC>`进入visual，j鼠标往下移动，O再往上一行追加文本
   添加一个- 表示列表符
3. Brief Summary(by yzl): 简要总结 ，yzl做的
4. `<CR> `表示换行 ， `<ESC>` 回到visual 模式
5. 0d$ 表示回到一行中的第0个位置，因为在上一个`<CR>会`进入到下一级的列表(默认在wiki文件如此，其他文件后缀暂时不管)
6. i{{{ 插入3个大于号，注意这边是成对的，然后摁下`<CR> `和`<Tab>`键，再摁下`<CR> `回到第三行的}}} ,但是}}}还有多余字符，于是
7. v0x v进入visual模式， 可是模式下选择到开头，并执行x删除字符命令。
8. k$a 往上一行，并调到行尾，追加字符
9. 1. so what? 为追加内容， 表示一个列表！

哈哈，原来如此，我是可以在vim中选择某一部分进行复制的，拷贝，直接y即可（v selectSomePart y)

最终效果:

```
- Brief Summary(by yzl):
{{{
    1. so what?<cursor>
}}}

```

### 21. vim-easy-align

[ easy-align ][39] 方便对齐

```
vipga 或者vip:EasyAlgin /---->/ 可以针对regexp表达式进行对齐

vip:EasyAlign 2/--->/ 还可以添加第二个，第三个位置  以及左对齐 右对齐
```

### 22. git push

我的vim的git操作

```
1. GitAdd .
2. GitCommit -am "Some Readme for this commit"
3. GitPush origin develop 
```

### 23. incsearch 和升级版的incsearch-easymotion

[ incsearch ][40]  升级版的搜索

[ incsearch-easymotion ][41] 支持模糊匹配和easymotion, 一般是本page中


### 24. Greplace整理了ag产生的结果j

[Greplace][42]  is  a vim plugin for doing a search and replace across many files, put the result in the new file. 

``` vim
"" 不见得提升多少，反而觉得开启indexing变慢
" if executable('ag')
"   set grepprg=ag\ --nogroup\ --nocolor
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"   let g:ctrlp_use_caching = 0
" endif

```


usage:

```
:Gsearch

:Greplace

```
### 25. 更正一个chalk zf bug细节

在[dbmrq/chalk][43]不能跟上注释，否则有问题！

``` vim
vmap zf <Plug>Chalk
nmap zf <Plug>Chalk
nmap zF <Plug>ChalkRange

nmap Zf <Plug>SingleChalk
                             " or specified count
nmap ZF <Plug>SingleChalkUp
                             " or specified count

nmap =z <Plug>ChalkUp
nmap -z <Plug>ChalkDown
vmap =z <Plug>ChalkUp
vmap -z <Plug>ChalkDown




```

另外该作者还写了一个[dbmrq/ditto][44]用于找出当前文件中重复的word(当打开md wiki org文件等自动进入dittoon模式)

``` vim
au FileType markdown,wiki,org,text,tex DittoOn  " Turn on Ditto's autocmds
nmap <leader>dt <Plug>ToggleDitto

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto	       " Call Ditto on operator movement

nmap =d <Plug>DittoNext
nmap -d <Plug>DittoPrev
nmap +d <Plug>DittoGood
nmap _d <Plug>DittoBad
nmap ]d <Plug>DittoMore
nmap [d <Plug>DittoLess



```

这边之所以不用官网提供的`,di`快捷键 是因为该快捷键被[Draw-It][45]占用了

很方便的一个小工具，通过上下左右键画图。

### 26. sketch and DrawIt
[sketch][47] 和 [ DrawIt ][48]都是vim底下绘制ascii图形的好工作

sketch(通过F4激活，F3重新留给最大化)有一个很好的功能，选中，然后鼠标左键， 即可完成边框添加，鼠标右键代表选择功能。

另外一个功能就是，可以通过Alt+鼠标左键，来控制拖拽`<C-鼠标左键的样式>`

1. 点号
2. 双点号
3. 井号


`<C-rightmouse>` 代表的是橡皮擦功能

sketch的功能更加艺术些 , 有个很magic的功能，鼠标点击一个字符会不断变化，具体变化规则如下

``` vim
  +---------------------+-----------------------------------------+
   |       Action        |                  Effect                 |
   |  -----------------  |  -------------------------------------  |
   |      Click/drag-+   |                                         |
   |           Btn-+ |   |                                         |
   |         Key-+ | |   |   Normal mode       Visual block        |
   |    Clicks-+ | | |   |                                         |
   +---------------------+-----------------------------------------+
   |  Lines        L c   |  - or +          Transparent box/line   |
   |               L d   |  ---                                    |
   |           2   L c   |  > < ^ v         Box/line with arrow    |
   |           3   L c   |  |                                      |
   |             S L c   |  Round/square    Opaque box/line        |
   |- - - - - - - - - - -|- - - - - - - - - - - - - - - - - - - - -|
   |  Paint      C L cd  |  Brush           Brush fill             |
   |             M L c   |  . -> : -> #                            |
   |- - - - - - - - - - -|- - - - - - - - - - - - - - - - - - - - -|
   |  Select       R c   |  Select          Erase                  |
   |               R d   |  Select          Transparent copy+move  |
   |             S R d   |                  Opaque copy+move       |
   |- - - - - - - - - - -|- - - - - - - - - - - - - - - - - - - - -|
   |  Erase      C R cd  |  Eraser                                 |
   |             M R cd  |  Fat eraser                             |
   +---------------------+-----------------------------------------+
   |        Map          |                  Effect                 |
   |  ----------------   |  -------------------------------------  |
   |  <leader>f          |  Flood fill (any character)             |
   +---------------------+-----------------------------------------+
```
其中

1. L 代表Left key,  
2. R 代表Right key
3. c代表点击(click), 
4. d代表拖拽(drag), cd地表两者结合
5. S代表(Shift), 
6. M 代表(Meta)
7. 2代表双击，
8. 3代表三击

<hr/>
DrawIt(通过`<LocalLeader>di`激活  `<LocalLeader>ds`关闭）通常是使用键盘上下左右进行控制。
DarwIt的功能更加传统些。

### 27. vim-sneak

[vim-sneak][49] 双字符查找器，比f,t更快更准(Jump to any location specified by two characters).

``` vim
" 让s跳转到下一个
let g:sneak#s_next = 1
let g:sneak#label =1
```

### 28. vim-hightlighyank

[vim-hightlighyank][50]  make the yanked region apprent!

```
"持久化已被赋值的区域，如果再次复制，会跳转到下一位置进行持久化"
let g:highlightedyank_highlight_duration = -1

```

### 29. vim-after-object

[vim-after-object][51] 可以选择某一个特征字符之后到结尾整行的信息。


1. 定义`va`几个特征字符
``` vim
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

```

2. 定义`va`的替换工具`v]`

``` vim
autocmd VimEnter * call after_object#enable([']','['], '=', ':', '-', '#', ' ')
```

此时`va=`等价于`v]=`


### 30. vim-multiple-cursors

最常用:

1. `<C-n>`表示向下匹配添加cursor
2. `<C-p>`表上向上匹配添加cursor
3. `vip<C-n>i""`代表在选取区域内添加cursors
4. `<Alt-n>`代表匹配所有 添加cursor



<hr/>

<hr/>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>
<hr/>


### 30. UML 时序图

[plantUML][53] 是一款方便的绘制java时序图，用例图等面向对象相关过程图的工具。

![plantuml-image][52]


例子

``` org
@startuml
/' give me wood'/

-> Eyes : Income
Brain -> Brain : UML spotted!
Brain -> Wang : UML alert!
loop 1000 times
    Wang -> Heart : request blood
    Wang <--  Heart : Blood!
@enduml

```
但是在vim中还是不能支持太多!


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
[38]:https://blog.csdn.net/demorngel/article/details/69054531 
[39]:https://github.com/junegunn/vim-easy-align 
[40]:https://github.com/haya14busa/incsearch.vim 
[41]:https://github.com/haya14busa/incsearch-easymotion.vim 
[42]:https://github.com/skwp/greplace.vim 
[43]:https://github.com/dbmrq/vim-chalk 
[44]:https://github.com/dbmrq/vim-ditto 
[45]:https://github.com/vim-scripts/DrawIt 
[46]:http://blog.163.com/lee_chau/blog/static/8883035201111134613637/ 
[47]:https://github.com/vim-scripts/sketch.vim/blob/master/sketch.tut 
[48]:https://github.com/vim-scripts/DrawIt 
[49]:https://github.com/justinmk/vim-sneak 
[50]:https://github.com/machakann/vim-highlightedyank 
[51]:https://github.com/junegunn/vim-after-object 
[52]:https://github.com/jueqingsizhe66/windowVimYe/blob/develop/img/plantUML.png 
[53]:http://plantuml.com/ 
