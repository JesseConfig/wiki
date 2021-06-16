
```bash
find -name "*.ts" |sort -V |sed 's/^/file /g' >list.txt
ffmpeg -f concat -safe 0 -i list.txt -vcodec copy -acodec copy xgdj.mp4
```
