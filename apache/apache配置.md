---
title: -Apache 配置
---

### 配置

```
<VirtualHost *:80>  
    #官方文档 http://httpd.apache.org/docs/2.4/

    #ServerAdmin webmaster@dummy-host.www.phpStudy.net  
    DocumentRoot "E:/selfweb/git_dev/test/"  
    ServerName fei.apache.test
    ServerAlias fei.apache.test  
    #ErrorLog "logs/dummy-host.www.phpStudy.net-error.log"  
    #CustomLog "logs/dummy-host.www.phpStudy.net-access.log" common    

	<Directory />
	    #没有index文件显示目录
		Options +Indexes +FollowSymLinks +ExecCGI  

		#没有index不显示目录,禁止访问
		#Options  -Indexes +FollowSymLinks    

		#是否禁用.htaccess 文件配置        
		AllowOverride All


		Order allow,deny
		Allow from all
		Require all granted

		#404 重定向
		#ErrorDocument 404 /test/404.html
	
	</Directory>
</VirtualHost>
```



[Apache 官方文档]: http://httpd.apache.org/docs/2.4/	"Apache 官方文档"

