## grep，sed，awk 介绍

### grep
 
grep命令家族由grep, egrep, fgrep 三个子命令组成，适用于不同的场景。具体如下：

grep 原生的grep命令，使用“标准正则表达式”作为匹配标准。

egrep 扩展的grep命令，相当于$(grep -E)，使用“扩展正则表达式”作为匹配标准。

fgrep 简化版的grep命令，不支持正则表达式，但搜索速度快，系统资源使用率低。

###  sed

sed全称是Stream EDitor

sed是一个流编辑器、行编辑器

### awk

awk是发明该工具三个作者姓名的首字母简称

awk是一个报表生成器，主要用于格式化输出。格式化文本输出器。