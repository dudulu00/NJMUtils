
### .DS_Store介绍

.DS_Store是Mac OS保存文件夹的自定义属性的隐藏文件，如文件的图标位置或背景色，相当于Windows的desktop.ini。

1. 禁止.DS_store生成：
打开 “终端” ，复制黏贴下面的命令，回车执行，重启Mac即可生效。
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

2. 恢复.DS_store生成：
defaults delete com.apple.desktopservices DSDontWriteNetworkStores
