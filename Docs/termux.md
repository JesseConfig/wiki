# [termux](https://termux.com/)

## [基本安装配置](https://www.sqlsec.com/2018/05/termux.html)
```
# 修改Termux的软件源
export EDITOR=vi
apt edit-sources 
deb http://mirrors.tuna.tsinghua.edu.cn/termux stable main
deb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main
deb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable
deb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable
apt install apt-transport-https tmux vim openssh

终端配色方案
脚本项目地址：https://github.com/Cabbagec/termux-ohmyzsh/
该脚本主要使用了zsh来替代bash作为默认 shell，并且支持色彩和字体样式，同时也激活了外置存储，可以直接访问SD卡下的目录。主题默认为 agnoster，颜色样式默认为 Tango，字体默认为 Ubuntu。
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)" 


# 安装SSH服务
$ pkg install openssh
# 设置密码
$ passwd
# 启动sshd服务
$ sshd
# 查询手机ip
$ ifconfig
# 查询当前用户
$ whoami
# 确认ssh服务的监听端口
netstat -ntlp | grep sshd
tcp        0      0 0.0.0.0:8022            0.0.0.0:*               LISTEN      28618/sshd          
tcp6       0      0 :::8022                 :::*                    LISTEN      28618/sshd
# 获取访问权限 访问本机存储
$ termux-setup-storage 
执行命令后，手机会弹框询问是否授权，"允许"即可
授权后会在家目录下生成 storage 子目录

# 将设备公钥添加都授权登录列表中
cat id_rsa.pub >> $HOME/.ssh/authorized_keys
# 开启ssh服务
sshd

模拟一个root的环境
pkg install proot -y
termux-chroot

定制常用按键
mkdir ~/.termux
vim ~/.termux/termux.properties
extra-keys = [ \
 ['ESC','|','/','HOME','UP','END','PGUP','DEL'], \
 ['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN','BKSP'] \
]
extra-keys = [ \
 ['ESC','|','/','`','UP','QUOTE','APOSTROPHE'], \
 ['TAB','CTRL','~','LEFT','DOWN','RIGHT','ENTER'] \
]

备份
termux-setup-storage
cd /data/data/com.termux/files
tar -zcf /sdcard/termux-backup.tar.gz home usr
恢复
termux-setup-storage
cd /data/data/com.termux/files
tar -zxf /sdcard/termux-backup.tar.gz --recursive-unlink --preserve-permissions

解决汉字乱码
vim ~/.vimrc
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030
source .vimrc
Termux Vim 自带了如下的配色：
ls /data/data/com.termux/files/usr/share/vim/vim82/colors
vim ~/.vimrc
set nu                " 显示行号
colorscheme desert    " 颜色主题
syntax on             " 打开语法高亮

```



## install ubuntu
Update termux: apt-get update && apt-get upgrade -y
Install wget: apt-get install wget -y
Install proot: apt-get install proot -y
Install git: apt-get install git -y
Go to HOME folder: cd ~
Download script: git clone https://github.com/MFDGaming/ubuntu-in-termux.git
Go to script folder: cd ubuntu-in-termux
Give execution permission: chmod +x ubuntu.sh
Run the script: ./ubuntu.sh -y
Now just start ubuntu: ./startubuntu.sh

git clone https://github.com/sqlsec/termux-install-linux
cd termux-install-linux
python termux-linux-install.py