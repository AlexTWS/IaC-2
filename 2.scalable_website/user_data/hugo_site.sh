#!/bin/bash
apt update -y
apt install nginx nodejs hugo -y

# HUGO SITE
hugo new site welcome
cd welcome/
git init
git clone https://github.com/adityatelange/hugo-PaperMod themes/hugo-PaperMod --depth=1 #install theme
echo 'theme = "hugo-PaperMod"' >> config.toml
hugo new posts/hello-from-terraform.md
echo "If you see this, everything is working just fine!" >> content/posts/hello-from-terraform.md
hugo

# NGINX CONFIG
systemctl start nginx
systemctl enable nginx
cat "nginx_config.txt" | tee /etc/nginx/sites-available/default
systemctl restart nginx