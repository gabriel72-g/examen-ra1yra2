#!bin/bash

sudo yum update -y
sudo yum install -y nginx
sudo yum install -y certbot python3-certbot-nginx
sudo yum install -y bind-utils
sudo yum install -y docker httpd-tools
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl enable nginx
sudo systemctl start docker

echo "dckr_pat_5YpJVfteru-al-FuoK_t_xH2QE0" | sudo docker login -u "gabriel72g" --password-stdin

sudo docker create --name temp gabriel72g/mi-web:latest
sudo docker cp temp:/usr/share/nginx/html/. usr/share/nginx/html/
docker rm temp

sudo htpasswd -bc /etc/nginx/conf.d/domain-gabriel.conf

cat<<EOT | sudo tee /etc/nginx/conf.d/domain-gabriel.conf
server{
    listen 80;
    server_name examenra2.ddns.net;
    root /usr/share/nginx/html;
    index index.html index.htm;

    auth_basic Área Restringida";
    auth_basic_user_file /etc/nginx/.htpasswd;
}
EOT
sudo nginx -t && sudo systemctl reload nginx

sudo sleep 180

sudo systemctl stop nginx

sudo certbot certonly --standalone -d examenra2.ddns.net\
--non-interactive --agree-tos -m gabriel.empresa.gomez@gmail.com --quiet

sudo systemctl start nginx

cat<<EOT | sudo tee /etc/nginx/conf.d/domain-gabriel.conf
server{
    listen 80;
    server_name examenra2.ddns.net;
    root /usr/share/nginx/html;
    index index.html index.htm;
}

server{
    listen 443 ssl;
    server_name examenra2.ddns.net;
    
    ssl_certificate /etc/letsencript/live/examenra2.ddns.net/fullchain.pem;
    ssl_certificate_key /etc/letsencript/live/examenra2.ddns.net/provkey.pem;    

    root/usr/share/nginx/html;
    index index.html index.htm;

    auth_basic Área Restringida";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
    try_files \$uri\$uri = 404;
    }
}
EOT

sudo nginx -t && sudo systemctl reload nginx