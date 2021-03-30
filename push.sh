#!/bin/bash

wall "wiki Push start "$(date +"%Y-%d-%m %R")

[ `pwd` == "/home/pi/wiki/wiki" ] || cd /home/pi/wiki/wiki
[ `pwd` == "/home/pi/wiki/wiki" ] && git add . && git commit -m "`date +%Y-%d-%m`" && git push

wall "wiki Push End "$(date +"%Y-%d-%m %R")
