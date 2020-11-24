#!/bin/bash

apt -y update
apt -y install php #installs PHP and Apache web server
apt -y install zip unzip

rm /var/www/html/index.html #remove default index.html
wget https://getgrav.org/download/core/grav-admin/latest #download latest release of Grav with admin panel
unzip latest
cp -r grav-admin/. /var/www/html #copy all files and folders including hidden ones into webroot
cd /var/www/html/
bin/gpm install quark #install qaurk theme
chown -R www-data:www-data /var/www/html/.

sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf #change AllowOverride into All for .htaccess file