FROM php:5.4.36-apache

MAINTAINER luointo <luointo@163.com>

# 替换源
COPY ./sources.list /etc/apt/sources.list

# 更新并安装vim
RUN apt-get update && apt-get install -y vim

# 启用rewrite模块
RUN a2enmod rewrite

# gd
RUN apt-get install -y \
		libfreetype6-dev \
        libjpeg62-turbo-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# pdo_mysql
RUN docker-php-ext-install pdo_mysql

# mysqli
RUN docker-php-ext-install mysqli

# mysql
RUN docker-php-ext-install mysql

# mbstring
RUN docker-php-ext-install mbstring
