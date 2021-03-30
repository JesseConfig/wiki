 # Git 笔记
 
 
- 修改git默认的编辑器
`git config –global core.editor vim`
 
- 新仓库创建提交 
``` 
echo "# NewGti" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:JesseConfig/LedeTomeXiaoyuC5.git
git push -u origin main
```
- 提交至已有仓库
```
git remote add origin git@github.com:JesseConfig/LedeTomeXiaoyuC5.git
git branch -M main
git push -u origin main
```
 
 
## 异常区

``` 
 ! [remote rejected] master -> master (shallow update not allowed)
```
 
使用了 `git clone --depth< number> `克隆的本地版本。

这会导致浅层克隆。这样一个克隆的限制是不能将它推送到一个新的存储库中。

这意味着你必须 unshallow 你的库。
` git remote add old< path-to-old-remote> ;`
 
之后，我们使用 git fetch 来获取旧遥控器上的剩余历史记录。
` git fetch --unshallow old `