Linux清除已删除软件包的配置文件

dpkg -l |grep "^rc"|awk '{print $2}' |xargs apt-get -y purge

列出最大安装的软件包，请使用以下命令
```
$ sudo apt-get install wajig
$ wajig large
$ apt-get install debian-goodies
$ dpigs
$ awk '{if ($1 ~ /Package/) p = $2; if ($1 ~ /Installed/) printf("%9d %sn", $2, p)}' /var/lib/dpkg/status
$ dpkg-query -Wf '${Installed-Size}t${Package}n' | sort -n | tail -n 10

```