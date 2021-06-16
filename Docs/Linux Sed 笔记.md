# Linux Sed 笔记

Linux取两个文件相同不同的部分
```
comm 
用法：comm [选项]... 文件1 文件2
逐行比较已排序的文件文件1 和文件2。

When FILE1 or FILE2 (not both) is -, read standard input.

如果不附带选项，程序会生成三列输出。第一列包含文件1 特有的行，第二列包含 文件2 特有的行，而第三列包含两个文件共有的行。

  -1            不输出文件1 特有的行
  -2            不输出文件2 特有的行
  -3            不输出两个文件共有的行

  --check-order                 检查输入是否被正确排序，即使所有输入行均成对
  --nocheck-order               不检查输入是否被正确排序
  --output-delimiter=STR        依照STR 分列
  --total           output a summary
  -z, --zero-terminated    以 NUL 字符而非换行符作为行尾分隔符
      --help            显示此帮助信息并退出
      --version         显示版本信息并退出

Note, comparisons honor the rules specified by 'LC_COLLATE'.

示例：
  comm -12 文件1 文件2  只打印在文件1 和文件2 中都有的行
  comm -3  文件1 文件2  打印在文件1 中有，而文件2 中没有的行。反之亦然。

```
- 取出IP
`/sbin/ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g' | sed 's/Bcast.*$//g'`


## 合并

- 以空格分割 合并所有行
`sed ':a;N;s/\n/ /;ba;'`
`awk '{ print $1 }' | sed ':a;N;s/\n/ /;ba;'`

- 以空格分割 拆分成多行
`sed 's/ /\n/g'`

- 合并匹配模式及其下一行
`sed '/匹配304175/{N;s/\n/ /}'`

- 不以句号结尾的行，和下一行合并。
`sed -i '/[^。]$/{N;s/\n/ /}'`

- 某一行（通过筛选条件定位到该行）和上一行进行合并 
`sed '{N;s/\(.*\)\n\(.*name.*\)/\1\2/;t merge;P;D};:merge p;d'`

**命令不加-e 需要用引号''引住**

- 在第四行后添加新字符串
`sed -e 4a\newline testfile `

## 删除

- 删除空行
`sed '/^$/d'`

-  2~5 行删除
`sed '2,5d'`

- 删除第 2 行
`sed '2d'`

- 删除 3 到最后一行
`sed '3,$d' `

- 删除包含指定内容的行
`sed  '/root/d'`

- 多个连续的空行变为一个空行
`sed '/^$/d;G'`
`sed '/^$/{N;/^\n*$/D}'`

## 插入

- 第二行后(亦即是加在第三行)加上	
`sed '2a Str'`

- 第二行前
`sed '2i Str'`

- 增加两行以上
```shell
sed '2a Str or ......\
> Str?'
```

- 每行加空白行
`sed 'G' FILE`

## 替换

- 搜寻并执行命令 找到root对应的行,把bash替换为blueshell 输出q是退出
`sed -n '/root/{s/bash/blueshell/;p;q}'`

- 搜寻并替换
`sed 's/要被取代的字串/新的字串/g'`

- 2-5行的内容取代
`sed '2,5c No 2-5 number'`

## 搜寻并显示
`sed '/root/p'`
- -n只打印包含模板的行。
`sed -n '/root/p'`



## 读

- 读第 5-7 行
`sed -n '5,7p'`

- 取出文件最后一行
`sed '$!d'`  

-逆向显示文件内容
`sed '1!G;h;$!d' FILE 或者 sed -n '1!G;h;$p' FILE`  


  
```note
Linux sed 命令是利用脚本来处理文本文件。

参数说明：

-e<script>或--expression=<script> 以选项中指定的script来处理输入的文本文件。

-f<script文件>或--file=<script文件> 以选项中指定的script文件来处理输入的文本文件。

-h或--help 显示帮助。

-n或--quiet或--silent 仅显示script处理后的结果。

-V或--version 显示版本信息。

动作说明：

a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～

a \text:在行后面追加文本；支持使用\n实现多行追加；

c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！

c \text:替换行为单行或多行文本；

d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；

i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；

i  \text:在行前面插入文本；支持使用\n实现多行插入；

p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～

p:显示模式空间的内容

s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！

w /path/to/somefile:保存模式空间匹配到的行至指定文件中；

r /path/from/somefile:读取指定文件的文本流至模式空间中匹配

高级编辑命令：

h：把模式空间中的内容覆盖至保持空间中；

H:把模式空间中的内容追加至保持空间中；

g:从保持空间取出数据覆盖至模式空间；

G：从保持空间取出数据追加至模式空间；

x:把模式空间的内容与保持空间中的内容进行互换；

n:读取匹配到的行的下一行至模式空间；

N:追加匹配到的行的下一行至模式空间；

d:删除模式空间中的行；

D:删除多行模式空间中的所有行。

sed -n 'n;p' FILE：显示偶数行；
sed 'n;d' FILE：显示奇数行；

sed '1!G;h;$!d' FILE：逆序显示文件的内容；
sed '$!d' FILE：取出最后一行；
sed '\$!N;$!D' FILE：取出文件后两行；
sed '/^$/d;G' FILE：删除原有的所有空白行，而后为所有的非空白行后添加一个空白行；

sed 'G' FILE：在原有的每行后方添加一个空白行；

```
  
  
  
  
  
```
#!/bin/sh
cat $1 | sed '{s|<[^>]*>||g;s/\t//g;/^$/d;/^[5,4]/d}'|sed '/^[a,0-9]/i\'|sed '/^[0-9].[0-9]\{1,\}$/{N;s|\n| |g}'| \
sed '{s/^a/- [ ] (A)/g;s/^b/- [ ] (B)/g;s/^c/- [ ] (C)/g;s/^d/- [ ] (D)/g;s/^e/- [ ] (E)/g;s/^f/- [ ] (F)/g}'
```



cat MG1.html | sed '{s|<[^>]*>||g;s/\t//g;/^$/d;/^[5,4]/d}'|sed '/^[a,0-9]/i\'|sed '/^[0-9].[0-9]\{1,\}$/{N;s|\n| |g}' | \
sed '{s/^[ \t]*//g'}' | \
sed '{s/^a/- [ ] (A)/g;s/^b/- [ ] (B)/g;s/^c/- [ ] (C)/g;s/^d/- [ ] (D)/g;s/^e/- [ ] (E)/g;s/^f/- [ ] (F)/g}'

cat MG1.html | sed '{s|<[^>]*>||g'
s/\t//g;
/^$/d;
/^[5,4]/d}'|

sed '/^[a,0-9]/i\'|
sed '/^[0-9].[0-9]\{1,\}$/{N;s|\n| |g}'

sed '{s/^[ \t]*//g'}' | \

sed '{s/^a/- [ ] (A)/g;s/^b/- [ ] (B)/g;s/^c/- [ ] (C)/g;s/^d/- [ ] (D)/g;s/^e/- [ ] (E)/g;s/^f/- [ ] (F)/g}'


sed -n '/<a /p' forum-index-fid-957.htm   | sed 's#<a \([^>]*\)>#--SYN--\1--FIN--#g; s/<//g; s/>//g' | sed 's/--SYN--/</g; s/--FIN--[^<]*</></g; s/[^<]*</</; s/--FIN--.*/>/;' | sed "s#<[^>]*href=\([^a-zA-Z>]*[^ >]*\)[^>]*># @\1@#g; s/<[^>]*>//g; s/'//g; s/@/ /g" >a.tzt
提取href= 

从html文件中提取超链接URL的shell脚本
sed -n '/<a /p' html.txt | sed 's#<a \([^>]*\)>#--SYN--\1--FIN--#g; s/<//g; s/>//g' | \
sed 's/--SYN--/</g; s/--FIN--[^<]*</></g; s/[^<]*</</; s/--FIN--.*/>/;' | \
sed "s#<[^>]*href=\([^a-zA-Z>]*http://[^ >]*\)[^>]*># @\1@#g; s/<[^>]*>//g; s/'//g; s/@/ /g" > url.txt

这里提取的是 <a href="http://domain/path/to/html.html"> 中的 http://domain/path/to/html.html