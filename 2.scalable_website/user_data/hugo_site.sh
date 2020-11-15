#!/bin/bash
apt update -y
apt install nginx nodejs hugo -y

# NGINX CONFIG
systemctl start nginx
systemctl enable nginx
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /home/ubuntu/welcome/public/;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
}
EOF
systemctl restart nginx

# HUGO SITE
cd /home/ubuntu
hugo new site welcome
cd welcome/
git init
git clone https://github.com/adityatelange/hugo-PaperMod themes/hugo-PaperMod --depth=1 #install theme
echo 'theme = "hugo-PaperMod"' >> config.toml
hugo new posts/hello-from-terraform.md
echo "If you see this, everything is working just fine!" >> content/posts/hello-from-terraform.md
hugo