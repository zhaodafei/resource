### 来自官方的PHP镜像版本为7.1-fpm
### 该版本只包含FPM不包括CLI,所以这里并不能执行composer
### 如果需要用PHP-CLI 需要再开一个CLI容器，或者安装同时包含FPM和CLI的版本

FROM php:7.1-fpm

### 设置环境变量
ENV TZ=Asia/Shanghai

MAINTAINER luointo <luointo@163.com>

COPY ./sources.list /etc/apt/sources.list

### 执行bash命令安装php所需的扩展


RUN apt-get update

# Install GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Install mbstring
RUN docker-php-ext-install mbstring

# Install PDO
# RUN docker-php-ext-install pdo_mysql
# RUN apt-get install -y libpq-dev
# RUN docker-php-ext-install pdo_pgsql



### 扩展php.ini
### COPY ./conf/php.ini /usr/local/etc/php/conf.d



