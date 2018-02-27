#!/usr/bin/env bash

# 自分のVirtualBoxのバージョンを指定してください
# VBOX_VER="5.2.6"

# Set timezone
timedatectl set-timezone Asia/Tokyo

yum -y update
yum -y install curl git unzip vim wget
yum -y install dkms bzip2 gcc make kernel-devel kernel-headers

# Install Apache
yum install -y httpd
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.orig
mv /home/vagrant/httpd.conf /etc/httpd/conf/httpd.conf

# Install php 7.1
yum -y remove php*
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum -y install --enablerepo=remi-php71 php php-cli php-fpm php-common php-devel php-json php-mbstring php-mysqlnd php-pdo php-process php-xml php-pecl-xdebug php-pecl-zip

mkdir -p /vagrant/www/tmp/profile

sudo cat << EOS >> /etc/php.d/15-xdebug.ini
zend_extension=/opt/remi/php71/root/usr/lib64/php/modules/xdebug.so
html_errors=on
xdebug.collect_vars=on
xdebug.collect_params=4
xdebug.dump_globals=on
xdebug.dump.GET=*
xdebug.dump.POST=*
xdebug.show_local_vars=on
xdebug.remote_enable = on
xdebug.remote_autostart=on↲
xdebug.remote_handler = dbgp
xdebug.remote_connect_back=on↲
xdebug.profiler_enable=0
xdebug.profiler_output_dir="/vagrant/www/tmp/profile"
xdebug.max_nesting_level=1000
xdebug.remote_host=192.168.123.1
xdebug.remote_port = 9001
xdebug.idekey = "phpstorm"
EOS

sudo cat << EOS >> /etc/opt/remi/php71/php.d/15-xdebug.ini
html_errors=on
xdebug.collect_vars=on
xdebug.collect_params=4
xdebug.dump_globals=on
xdebug.dump.GET=*
xdebug.dump.POST=*
xdebug.show_local_vars=on
xdebug.remote_enable = on
xdebug.remote_autostart=on↲
xdebug.remote_handler = dbgp
xdebug.remote_connect_back=on↲
xdebug.profiler_enable=0
xdebug.profiler_output_dir="/vagrant/www/tmp/profile"
xdebug.max_nesting_level=1000
xdebug.remote_host=192.168.123.1
xdebug.remote_port = 9001
xdebug.idekey = "phpstorm"
EOS

cd /tmp
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# Install MySQL
yum remove -y mariadb-libs
rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el6-11.noarch.rpm
yum -y install mysql-community-server
# yum install -y mysql mysql-devel mysql-server mysql-utilities
mysqld --user=mysql --initialize
mv /etc/my.cnf /etc/my.cnf.orig
mv /home/vagrant/my.cnf /etc/my.cnf

# Start Services
service httpd start
service httpd enable
service mysqld start
service mysqld enable

# Install GuestAdditions
# wget http://download.virtualbox.org/virtualbox/$VBOX_VER/VBoxGuestAdditions_$VBOX_VER.iso
# mkdir /VBoxGuestAdditions
# mount -o loop,ro VBoxGuestAdditions_$VBOX_VER.iso /VBoxGuestAdditions
# sh /VBoxGuestAdditions/VBoxLinuxAdditions.run
# rm VBoxGuestAdditions_$VBOX_VER.iso
# umount /VBoxGuestAdditions
# rmdir /VBoxGuestAdditions