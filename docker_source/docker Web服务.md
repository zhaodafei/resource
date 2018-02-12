Web服务(Apache、Nginx、Tomcat、Jetty)与应用(LAMP、CMS-WordPress&Ghost、Jenkins、Gitlab)

Web服务和应用是目前信息技术领域的热门技术。如何使用Docker来运行常见的Web服务器（包括Apache、Nginx、Tomcat等），以及一些常用应用（LAMP、CMS等）。包括具体的镜像构建方法与使用步骤。

两种创建镜像的过程。其中一些操作比较简单的镜像使用Dockerfile来创建，而像Weblogic这样复杂的应用，则使用commit方式来创建。

## Apache
Apache是一个高稳定性的、商业级别的开源Web服务器。目前Apache已经是世界使用排名第一的Web服务器软件。由于其良好的跨平台和安全性，Apache被广泛应用在多种平台和操作系统上。作为Apache软件基金会支持的项目，它的开发者社区完善而高效。自1995年发布至今，一直以高标准进行维护与开发。Apache名称源自美国的西南部一个印第安人部落：阿帕奇族，它支持类UNIX和Windows系统。

### 1.使用官方镜像

官方提供了名为httpd的Apache镜像，可以作为基础Web服务镜像。

编写Dockerfile文件，内容如下：
```
FROM httpd:2.4
COPY ./public-html /usr/local/apache2/htdocs/
```
创建项目目录public-html，并在此目录下创建index.html文件：Hello, Docker!

构建自定义镜像：```$ docker build -t apache2-image .```

构建完成后，使用docker run指令运行镜像：```$ docker run -it --rm --name apache-container -p 80:80 apache2-image```

通过本地的80端口即可访问静态页面。

也可以不创建自定义镜像，直接通过映射目录方式运行Apache容器：
```
$ docker run -it --rm --name my-apache-app -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4
```
再次打开浏览器，可以再次看到页面输出。

### 2.使用自定义镜像

首先，创建一个apache_ubuntu工作目录，在其中创建Dockerfile文件、run.sh文件和sample目录：
```
$ mkdir apache_ubuntu && cd apache_ubuntu

$ touch Dockerfile run.sh

$ mkdir sample
```
下面是Dockerfile的内容和各个部分的说明：
```
#设置继承自用户创建的sshd镜像

FROM sshd:Dockerfile

#创建者的基本信息

MAINTAINER docker_user (user@docker.com)

#设置环境变量，所有操作都是非交互式的

ENV DEBIAN_FRONTEND noninteractive

#安装

RUN apt-get -yq install apache2&&\

rm -rf /var/lib/apt/lists/*

RUN echo "Asia/Shanghai" > /etc/timezone && \

dpkg-reconfigure -f noninteractive tzdata

#注意这里要更改系统的时区设置，因为在web应用中经常会用到时区这个系统变量，默认的ubuntu会让你的应用程序发生不可思议的效果

#添加用户的脚本，并设置权限，这会覆盖之前放在这个位置的脚本

ADD run.sh /run.sh

RUN chmod 755 /*.sh

#添加一个示例的web站点，删掉默认安装在apache文件夹下面的文件，并将用户添加的示例用软链接,链到/var/www/html目录下面

RUN mkdir -p /var/lock/apache2 && mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html 

COPY sample/ /app

#设置apache相关的一些变量，在容器启动的时候可以使用-e参数替代

ENV APACHE_RUN_USER www-data

ENV APACHE_RUN_GROUP www-data

ENV APACHE_LOG_DIR /var/log/apache2

ENV APACHE_PID_FILE /var/run/apache2.pid

ENV APACHE_RUN_DIR /var/run/apache2

ENV APACHE_LOCK_DIR /var/lock/apache2

ENV APACHE_SERVERADMIN admin@localhost

ENV APACHE_SERVERNAME localhost

ENV APACHE_SERVERALIAS docker.localhost

ENV APACHE_DOCUMENTROOT /var/www

EXPOSE 80

WORKDIR /app

CMD ["/run.sh"]
```
此sample站点的内容为输出Hello Docker！。然后在sample目录下创建index.html文件，内容如下：Hello, Docker!

run.sh脚本内容也很简单，只是启动apache服务：

```$ cat run.sh```
```
#!/bin/bash
exec apache2 -D FOREGROUND
```
下面，用户开始创建apache:ubuntu镜像：

使用docker build命令创建apache:ubuntu镜像，注意命令最后的“.”。
```
$ docker build -t apache:ubuntu .
```
下面开始使用docker run指令测试镜像。可以使用-P参数映射需要开放的端口（22和80端口）：
```
$ docker run -d -P apache:ubuntu

64681e2ae943f18eae9f599dbc43b5f44d9090bdca3d8af641d7b371c124acfd

$ docker ps -a

CONTAINER ID        IMAGE            COMMAND     CREATED     STATUS   PORTS                                                                NAMES

64681e2ae943        apache:ubuntu "/run.sh"       2 seconds    Up 1       0.0.0.0:49171->22/tcp, 0.0.0.0:49172->80/tcp    naughty_poincare
```
在本地主机上用curl抓取网页来验证刚才创建的sample站点：
```
$ curl 127.0.0.1:49172

Hello Docker!
```
也可以在其他设备上通过访问宿主主机ip:49172来访问sample站点。

在apache镜像的Dockerfile中只用EXPOSE定义了对外开放的80端口，而在docker ps -a命令的返回中，却看到新启动的容器映射了两个端口：22和80。

重要：但是实际上，当尝试使用SSH登录到容器时，会发现无法登录。这是因为在run.sh脚本中并未启动SSH服务。这说明在使用Dockerfile创建镜像时，会继承父镜像的开放端口，但却不会继承启动命令。

因此，需要在run.sh脚本中添加启动sshd的服务的命令：

```$ cat run.sh```
```
#!/bin/bash
/usr/sbin/sshd & exec apache2 -D FOREGROUND
```
再次创建镜像：
```
$ docker build -t apache:ubuntu .
```
这次创建的镜像，将默认会同时启动SSH和Apache服务。

来看看如何映射本地目录。可以通过映射本地目录的方式，来指定容器内Apache服务响应的内容，例如映射本地主机上当前目录下的www目录到容器内的/var/www目录：
```
$ docker run -i -d -p 80:80 -p 103:22 -e APACHE_SERVERNAME=test  -v `pwd`/www:/var/www:ro apache:ubuntu
```
在当前目录内创建www目录，并放上自定义的页面index.html。

在本地主机上可访问测试容器提供的Web服务，查看获取内容为新配置的index.html页面信息。

## Nginx

> Nginx是一款功能强大的开源反向代理服务器，支持HTTP、HTTPS、SMTP、POP3、IMAP等协议。它也可以作为负载均衡器、HTTP缓存或Web服务器。Nginx一开始就专注于高并发和高性能的应用场景。它使用类BSD开源协议，支持Linux、BSD、Mac、Solaris、AIX等类Unix系统，同时也有Windows上的移植版本。

1.使用官方镜像

用户可以使用docker run指令直接运行官方Nginx镜像：
```
$ docker run -d -p 80:80 --name webserver nginx

34bcd01998a76f67b1b9e6abe5b7db5e685af325d6fafb1acd0ce84e81e71e5d
```
然后使用docker ps指令查看当前运行的docker ps指令查看当前运行的容器：
```
$ docker ps

CONTAINER ID IMAGE COMMAND     CREATED  STATUS PORTS                        NAMES

34bcd01998a7 nginx "nginx..."  2min ago Up     0.0.0.0:80->80/tcp, 443/tcp  webserver
```
目前Nginx容器已经在0.0.0.0:80启动，并映射了80端口，此时可以打开浏览器访问此地址，就可以看到Nginx输出的页面。

2.自定义Web页面

同样的，创建index.html文件，并将index.html文件挂载至容器中，即可看到显示自定义的页面。
```
$ docker run --name nginx-container -p 80:80 -v index.html:/usr/share/nginx/html:ro -d nginx
```
另外，也可以使用Dockerfile来构建新镜像。Dockerfile内容如下：
```
FROM nginx
COPY ./index.html /usr/share/nginx/html
```
开始构建镜像my-nginx：
```
$ docker build -t my-nginx .
```
构建成功后执行docker run指令：
```
$ docker run --name nginx-container -d my-nginx
```

## Tomcat

Tomcat是由Apache软件基金会下属的Jakarta项目开发的一个Servlet容器，按照Sun Microsystems提供的技术规范，实现了对Servlet和Java Server Page（JSP）的支持。同时，它提供了作为Web服务器的一些特有功能，如Tomcat管理和控制平台、安全域管理和Tomcat阀等。由于Tomcat本身也内含了一个HTTP服务器，也可以当作一个单独的Web服务器来使用。

首先，尝试在Docker Hub上搜索已有的Tomcat相关镜像的个数：
```
$ docker search tomcat |wc -l 

285
```
可以看到，已经有285个相关镜像。如是个人开发或测试，可以随意选择一个镜像，按照提示启动应用即可。

下面以Tomcat 7.0为例介绍定制Tomcat镜像的步骤:

### 1.准备工作

创建tomcat7.0_jdk1.6文件夹，从www.oracle.com网站上下载sun_jdk 1.6压缩包，解压为jdk目录。

创建Dockerfile和run.sh文件：
```
$ mkdir tomcat7.0_jdk1.6

$ cd tomcat7.0_jdk1.6/

$ touch Dockerfile run.sh
```
下载Tomcat，可以到官方网站下载最新的版本，也可以直接使用下面链接中给出的版本：
```
$ wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.56/bin/apache-tomcat-7.0.56.zip

$ ls

Dockerfile  apache-tomcat-7.0.56   jdk  run.sh
```
### 2.Dockerfile文件和其他脚本文件

Dockerfile文件内容如下：

```
#设置继承自用户创建的sshd镜像

FROM sshd:Dockerfile

#下面是一些创建者的基本信息

MAINTAINER docker_user (user@docker.com)

#设置环境变量，所有操作都是非交互式的

ENV DEBIAN_FRONTEND noninteractive

#注意这里要更改系统的时区设置

RUN echo "Asia/Shanghai" > /etc/timezone && \

dpkg-reconfigure -f noninteractive tzdata

#安装跟tomcat用户认证相关的软件

RUN apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \

apt-get clean && \

rm -rf /var/lib/apt/lists/*

#设置tomcat的环境变量，若读者有其他的环境变量需要设置，也可以在这里添加。

ENV CATALINA_HOME /tomcat

ENV JAVA_HOME /jdk

#复制tomcat和jdk文件到镜像中

ADD apache-tomcat-7.0.56 /tomcat

ADD jdk /jdk

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh

ADD run.sh /run.sh

RUN chmod +x /*.sh

RUN chmod +x /tomcat/bin/*.sh

EXPOSE 8080

CMD ["/run.sh"]
```

创建tomcat用户和密码脚本文件create_tomcat_admin_user.sh文件，内容为：

```
#!/bin/bash
if [ -f /.tomcat_admin_created ]; then
echo "Tomcat 'admin' user already created"
exit 0
fi
#generate password
PASS=${TOMCAT_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${TOMCAT_PASS} ] && echo "preset" || echo "random" )
echo "=> Creating and admin user with a ${_word} password in Tomcat"
sed -i -r 's/<\/tomcat-users>//' ${CATALINA_HOME}/conf/tomcat-users.xml
echo '' >> ${CATALINA_HOME}/conf/tomcat-users.xml
echo '' >> ${CATALINA_HOME}/conf/tomcat-users.xml
echo '' >> ${CATALINA_HOME}/conf/tomcat-users.xml
echo '' >> ${CATALINA_HOME}/conf/tomcat-users.xml
echo '' >> ${CATALINA_HOME}/conf/tomcat-users.xml
echo "
script,manager-jmx,admin-gui, admin-script\"/>" >> ${CATALINA_HOME}/conf/
tomcat-users.xml
echo '' >> ${CATALINA_HOME}/conf/tomcat-users.xml
echo "=> Done!"
touch /.tomcat_admin_created
echo "========================================================================"
echo "You can now configure to this Tomcat server using:"
echo ""
echo "    admin:${PASS}"
echo ""
echo "========================================================================"
```

编写run.sh脚本文件，内容为：

```
#!/bin/bash

if [ ! -f /.tomcat_admin_created ]; then
/create_tomcat_admin_user.sh
fi
/usr/sbin/sshd -D &
exec ${CATALINA_HOME}/bin/catalina.sh run
```


### 3.创建和测试镜像

通过下面的命令创建镜像tomcat7.0:jdk1.6
```
$ docker build -t tomcat7.0:jdk1.6 .
```
启动一个tomcat容器进行测试：
```
$ docker run -d -P tomcat7.0:jdk1.6

3cd4238cb32a713a3a1c29d93fbfc80cba150653b5eb8bd7629bee957e7378ed
```
通过docker logs得到tomcat的密码aBwN0CNCPckw：
```
$ docker logs 3cd

=> Creating and admin user with a random password in Tomcat
=> Done!
=======================================================================
You can now configure to this Tomcat server using:
admin:aBwN0CNCPckw
```
查看映射的端口信息：

```
$ docker ps

CONTAINER ID   IMAGE                COMMAND  CREATED  STATUS              PORTS                                                                   NAMES

3cd4238cb32a    tomcat7.0:jdk1.6 "/run.sh"   4 seconds  Up 3 seconds      0.0.0.0:49157->22/tcp, 0.0.0.0:49158->8080/tcp   cranky_wright
```

在本地使用浏览器登录Tomcat管理界面，访问本地的49158端口，即http://127.0.0.1:49158。(22端口是ssh的)

输入从docker logs中得到的密码，成功进入管理界面。

在实际环境中，可以通过使用-v参数来挂载Tomcat的日志文件、程序所在目录、以及与Tomcat相关的配置。

## Jetty
Jetty是一个优秀的开源Servlet容器，以其高效、小巧、可嵌入式等优点深得人心，它为基于Java的Web内容（如JSP和Servlet）提供运行环境。Jetty基于Java语言编写，它的API以一组JAR包的形式发布。开发人员可以将Jetty容器实例化成一个对象，可以迅速为一些独立运行的Java应用提供Web服务。相对老牌的Tomcat，Jetty架构更合理，性能更优。尤其在启动速度上，让Tomcat望尘莫及。Jetty目前在国内外互联网企业中应用广泛。

DockerHub官方提供了Jetty镜像，直接运行docker run指令即可：

```
$ docker run -d jetty
```

使用docker ps指令查看正在运行中的jetty容器：

```
$ docker ps

CONTAINER ID  IMAGE COMMAND                CREATED  STATUS  PORTS     NAMES

f7f1d70f2773  jetty "/docker-entrypoint.b" x ago    Up      8080/tcp  lonely_poitras
```
当然，还可以使用-p参数映射运行端口：
```
$ docker run -d -p 80:8080 -p 443:8443 jetty

7bc629845e8b953e02e31caaac24744232e21816dcf81568c029eb8750775733
```
使用宿主机的浏览器访问container-ip:8080，即可获得Jetty运行页面，由于当前没有内容，会提示错误信息。

## LAMP
LAMP（Linux-Apache-MySQL-PHP）是目前流行的Web工具栈，其中包括：Linux操作系统，Apache网络服务器，MySQL数据库，Perl、PHP或者Python编程语言。其组成工具均是成熟的开源软件，被大量网站所采用。和Java/J2EE架构相比，LAMP具有Web资源丰富、轻量、快速开发等特点；和微软的.NET架构相比，LAMP更具有通用、跨平台、高性能、低价格的优势。因此LAMP无论是在性能、质量还是价格方面都是企业搭建网站的首选平台。
现在也有人用Nginx替换Apache，称为LNMP或LEMP，但并不影响整个框架的选型原则，是彼此十分类似的技术栈。

可以使用自定义Dockerfile或者Compose方式运行LAMP，同时社区也提供了十分成熟的linode/lamp和tutum/lamp镜像。

下面介绍后两种方法。

### 1.使用linode/lamp镜像

首先，执行docker run指令，直接运行镜像，并进入容器内部bash shell：
```
$ docker run -p 80:80 -t -i linode/lamp /bin/bash

root@e283cc3b2908:/#
```

在容器内部shell启动apache以及mysql服务：
```
$ root@e283cc3b2908:/# service apache2 start

* Starting web server apache2

$ root@e283cc3b2908:/# service mysql start

* Starting MySQL database server mysqld                                 [ OK ]

* Checking for tables which need an upgrade, are corrupt or were not closed cleanly.
```

此时镜像中apache、mysql服务已经启动，可使用docker ps指令查看运行中的容器：
```
$ docker ps -aCONTAINER ID IMAGE       COMMAND     CREATED  STATUS       PORTS

NAMESe283cc3b2908 linode/lamp "/bin/bash" x ago    Up x seconds 0.0.0.0:80->80/tcp trusting_mestorf
```
此时通过浏览器访问本地80端口即可看到默认页面。

### 2.使用tutum/lamp镜像

首先，执行docker run指令，直接运行镜像：
```
$ docker run -d -p 80:80 -p 3306:3306 tutum/lamp
```
容器启动成功后，打开浏览器，访问demo页面。

## CMS
内容管理系统（Content Management System，CMS）指的是提供内容编辑服务的平台程序。CMS可以让不懂编程的用户方便又轻松地发布、更改和管理各类数字内容（主要以文本和图像为主）。以Wordpress和Ghost两个流行的CMS软件为例，介绍如何制作和使用对应的Docker镜像。

### WordPress

WordPress是风靡全球的开源内容管理系统，是博客、企业官网、产品首页等内容相关平台的主流实现方案之一。类似项目还有Drupal、Joomla、Typo3等。

WordPress基于PHP和MySQL，架构设计简单明了，支持主题，插件和各种功能模块。更重要的是，WordPress拥有庞大的社区，在线资源非常丰富，并且在各大网络空间商和云平台中受到广泛的支持。根据2013年8月的统计数据，流量排名前一千万的网站中其使用率高达22%。

#### 1.使用官方镜像

首先，通过Docker Hub下载官方wordpress镜像：
```
$ docker pull wordpress
```
然后，就可以创建并运行一个wordpress容器，并连接到mysql容器：
```
$ docker run --name some-wordpress --link some-mysql:mysql -d wordpress
```
同样，用户可以使用-p参数来进行端口映射：
```
$ docker run --name some-wordpress --link some-mysql:mysql -p 8080:80 -d wordpress
```
启动成功后，可在浏览器中访问http://localhost:8080来打开WordPress页面。

#### 2.使用Compose搭建WordPress应用

可以使用Compose来一键搭建WordPress应用。

首先，新建docker-compose.yml文件：

```
wordpress:
image: wordpress
links:
- db:mysql
ports:
- 8080:80
db:
image: mariadb
environment:
MYSQL_ROOT_PASSWORD: example
```
然后执行：
```
$ docker-compose up
```
> 如果提示没有docker-compose命令，可以通过pip install docker-compose来在线安装。
待服务启动后，即可打开浏览器访问本地8080端口打开WordPress配置界面。

### Ghost

Ghost是一个广受欢迎的开源博客平台，使用JavaScript编写，以MIT协议发布。它的设计非常简约，使用起来体验优异，非常适合做内容发布，故而受到很多极客或技术工作者的喜爱。可以直接使用Docker Hub提供的官方Ghost镜像。

直接使用docker run指令运行：
```
$ docker run --name ghost-container -d ghost
```
至此已经成功启动了一个Ghost容器，内含Ghost实例并监听默认的2368服务端口。

当然可以对服务进行端口映射，如下所示：
```
$ docker run --name ghost-container-1 -p 8080:2368 -d ghost

df116b7d570b3456950f4d7c22ff6911124427d16635080817e884922b491a2d
```
还可以挂载已有的内容到Ghost容器内：
```
$ docker run --name some-ghost -v /path/to/ghost/blog:/var/lib/ghost ghost
```
## 持续开发与管理

信息行业日新月异，如何响应不断变化的需求，快速适应和保证软件的质量？持续集成（Continuous integration，CI）正是针对这类问题的一种开发实践，它倡导开发团队定期进行集成验证。集成通过自动化的构建来完成，包括自动编译、发布和测试，从而尽快地发现错误。CI所描述的软件开发是从原始需求识别到最终产品部署整个过程中，需求以小批量形式在团队的各个角色间顺畅流动，能够以较短地周期完成需求的小粒度频繁交付。整个过程中，需求分析、产品的用户体验和交互设计、开发、测试、运维等角色需要密切协作。

持续集成特点包括：从检出代码、编译构建、运行测试、结果记录、测试统计等都是自动完成的，减少人工干预。需要有持续集成系统的支持，包括代码托管机制支持，以及集成服务器等。

持续交付（Continuous delivery，CD）则是经典的敏捷软件开发方法的自然延伸，它强调产品在修改后到部署上线的流程要敏捷化、自动化。甚至一些较小的改变也要今早的部署上线，这跟传统软件在较大版本更新后才上线的思想不同。

### Jenkins

Jenkins是一个得到广泛应用的持续集成和持续交付的工具。作为开源软件项目，它旨在提供一个开放易用的持续集成平台。Jenkins能实时监控集成中存在的错误，提供详细的日志文件和提醒功能，并用图表的形式形象地展示项目构建的趋势和稳定性。Jenkins特点包括安装配置简单、支持详细的测试报表、分布式构建等。

自2.0版本，Jenkis推出了Pipeline as Code，帮助Jenkins实现对CI和CD更好的支持。通过Pipeline，将原本独立运行的多个任务连接起来，可以实现十分复杂的发布流程。Jenkins官方在Docker Hub上提供了全功能的基于官方发布版的Docker镜像。

可以方便地使用docker run指令一键部署Jenkins服务，如下所示：
```
$ docker run -p 8080:8080 -p 50000:50000 jenkins
```
Jenkins容器启动成功后，可以打开浏览器访问8080端口，查看Jenkins管理界面。

目前运行的容器中，数据会存储在工作目录/var/jenkins_home中，这包括Jenkins中所有的数据，包括插件和配置信息等。

如果需要数据持久化，可以使用数据卷机制：
```
$ docker run -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home jenkins
```
以上指令会将Jenkins数据存储于宿主机的/your/home目录（需要确保/your/home目录对于容器内的Jenkins用户是可访问的）下。

当然也可以使用数据卷容器：
```
$ docker run --name myjenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins
```

### Gitlab

Gitlab是一款非常强大的开源源码管理系统。它支持基于Git的源码管理、代码评审、issue跟踪、活动管理、wiki页面，持续集成和测试等功能。

基于Gitlab，用户可以自己搭建一套类似Github的开发协同平台。Gitlab官方提供了社区版本（Gitlab CE）的DockerHub镜像。

可以直接使用docker run指令运行：

```
$ docker run --detach \
--hostname gitlab.example.com \
--publish 443:443 --publish 80:80 --publish 23:23 \
--name gitlab \
--restart always \
--volume /srv/gitlab/config:/etc/gitlab \
--volume /srv/gitlab/logs:/var/log/gitlab \
--volume /srv/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest

dbae485d24492f656d2baf18526552353cd55aac662e32491046ed7fa033be3a
```

成功运行镜像后，可以打开浏览器，访问Gitlab服务管理界面。