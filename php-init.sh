#!/bin/bash
# 如果是已安裝了，但想重裝下
# sudo apt-get remove --purge '^php.*'

echo "要裝哪個 PHP 版本 ?"
read php_version

echo "BEFORE: $(date +"%I %M %S")"
sleep 5
echo "AFTER: $(date +"%I %M %S")"

# 要安裝的套件列表
php_packages=(
                "curl"
                "mbstring"
                "zip"
                "mysql"
                "xml"
                "dev"
            )

echo "將會裝這些套件"
echo ${php_packages[@]}
echo "即將安裝 PHP $php_version 版本，10 秒後開始"
sleep 5

sudo add-apt-repository -y ppa:ondrej/php

sudo apt-get -y update

# 使用 for 迴圈依序處理每個 PHP 版本
echo "正在安裝 PHP $php_version 相關套件..."
echo "正在安裝 php$php_version..."
sudo apt-get -y install "php$php_version"

# 安裝指定版本的套件
for package in "${php_packages[@]}"; do
    echo "正安裝 php$php_version-$package..."
    sudo apt-get -y install "php$php_version-$package"
done

echo "已安裝 PHP $php_version 相關套件。"

echo "安裝 composer 套件管理工具"
php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
