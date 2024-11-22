
sudo apt install openssl

sudo sh -c "echo -n 'rocio:' >> /etc/nginx/.htpasswd" 
sudo sh -c "openssl passwd -apr1 'deaw'>> /etc/nginx/.htpasswd"


sudo sh -c "echo -n 'contarino:' >> /etc/nginx/.htpasswd" 
sudo sh -c "openssl passwd -apr1 'deaw'>> /etc/nginx/.htpasswd"


