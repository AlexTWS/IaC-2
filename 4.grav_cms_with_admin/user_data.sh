#!/bin/bash

apt -y update
apt -y install php #installs PHP and Apache web server
apt -y install zip unzip

https://getgrav.org/download/core/grav-admin/latest #download latest release of Grav with admin panel
unzip latest -d /var/www/html/ #unzip folder into webroot
cd /var/www/html/grav-admin/
bin/gpm install quark #install qaurk theme

sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf