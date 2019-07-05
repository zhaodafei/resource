---
title: -vnc server
---
### `centos7`  `gnome`桌面,安装vnc

````shell
####centos7 安装完没有修改配置文件
01) 首先检查当前系统是桌面用的KED还是gnome或者其他
ll /usr/bin/*session*
ps -A | grep KED
ps -A | grep gnome
ps -A | egrep -i "gnome|kde|mate|cinnamon|lx|xfce|jwm"

02)安装桌面(上面如果有桌面则这里不需要安装)
yum grouplist  #查看系统中以组安装的包
yum groupinstall -y "GNOME Desktop"

03 安装vncserrver
yum install tigervnc-server -y  #安装vncserver 服务端
vncserver   #启动服务,接下来输入密码即可
````

![vnc centos7](/img/other/centos7.png "vnc centos7")

#### centos7`的`vcn`中`xstartup`配置文件(原来的配置,不需要修改)

```shell
#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
/etc/X11/xinit/xinitrc
vncserver -kill $DISPLAY
```

![vnc xstartup](/img/other/centos7_xstartup.png "vnc xstartup")

### `ubuntu16` `gnome`安装 vnc server

```shell
#### 安装完成后需要修改配置文件,否则出现灰屏和一个大大的x号
01) 首先检查当前系统是桌面用的KED还是gnome或者其他,我的是gnome,所以这里不在安装桌面(需要的自行安装)
ll /usr/bin/*session*
ps -A | grep KED
ps -A | grep gnome
ps -A | egrep -i "gnome|kde|mate|cinnamon|lx|xfce|jwm"
#---------------安装----------------------
sudo apt-get update
sudo apt-get install tightvncserver  #如果需要桌面自己安装合适的桌面
vncserver
#-----------------启动-------------------
01) 如果你想启动root桌面,就用sudo vncserver,访问当前普通用户就用vncserver
sudo vncserver    #root用户 设置密码,我这里用123456 测试
vncserver        #当前普通用户
vncpasswd        #修改密码

#---------------------------------------------
启动后会在 /root 目录下增加一个 .vnc 的目录
访问前准备:修改 xstartup 文件
02) 在 xstartup 中修改
#/etc/X11/Xsession      ---------注释这一行,添加下面内容
unset DBUS_SESSION_BUS_ADDRESS
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &

#---------xstartup 文件中的所有内容如下---------
#!/bin/sh

xrdb $HOME/.Xresources
xsetroot -solid grey
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
#/etc/X11/Xsession
unset DBUS_SESSION_BUS_ADDRESS
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &
#---------------------------------------------
vncserver :1   #启动1桌面,重启vncserver 
#---------------------------------------------
访问端口:
vnc 默认端口是5900;  启动的时候注意有个空格[ vncserver :1  ]
如果你启动的是 vncserver :1 那么访问就是 http://127.0.0.1:5901
如果你启动的是 vncserver :2 那么访问就是 http://127.0.0.1:5902

ps -aux | grep vnc  可以看到里面有端口的说明 -rfbauth /root/.vnc/passwd -rfbport 5901


```

![vnc ubuntu16](/img/other/ubuntu16.png "vnc ubuntu16")

#### `ubuntu16` 中 `vnc`的`xstartup`配置(修改后的)

```shell
#!/bin/sh

xrdb $HOME/.Xresources
xsetroot -solid grey
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
#/etc/X11/Xsession
unset DBUS_SESSION_BUS_ADDRESS
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &

```

![vnc xstartup](/img/other/ubuntu16_xstartup.png "vnc xstartup")

### 其他

```shell
vncserver :1   #启动1桌面
vncserver :2   #启动2桌面
vncserver -kill :1  #停止1桌面
vncserver -kill :2  #停止2桌面
```



下载视图工具:  [realvnc download](https://www.realvnc.com/en/connect/download/viewer/ "realvnc download")



























