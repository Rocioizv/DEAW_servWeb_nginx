
        ## IMPORTANTE
#Para poder acceder a los dominios hay que editar el archivo hosts
#C:\Windows\System32\drivers\etc\hosts
    #192.168.57.102 rconcan.com www.rconcan2.com
    #192.168.57.102 rconcan2.com www.rconcan2.com

!/bin/bash

#CONFIGURACIÓN GENERAL DEL SERVIDOR Y REPOSITORIOS

#Actualizar repositorios e instalar el servidor Nginx
    sudo apt update 
    sudo apt install -y nginx
    sudo apt install -y git
 #comprobar el funcionamiento de nginx
    sudo systemctl status nginx


#CREACIÓN DEL PRIMER SITIO WEB

#Crea la carpeta para la página web
    sudo mkdir -p /var/www/rocio_web/html
    cd /var/www/rocio_web/html
    git clone https://github.com/cloudacademy/static-website-example.git

#Administrar permisos
     sudo chown -R www-data:www-data /var/www/rocio_web/html
     sudo chmod -R 755 /var/www/rocio_web

#Creación del archivo y del enlace simbólico
    # sudo bash -c 'cat > /etc/nginx/sites-available/rconcan <<EOF
    #     server {
    #         listen 80;
    #         listen [::]:80;
    #         root /var/www/rocio_web/html/static-website-example/;
    #         index index.html index.htm index.nginx-debian.html;
    #         server_name rconcan;
    #         location / {
    #             try_files $uri $uri/ =404;
    #         }
    #     }
    # EOF'

    cp /vagrant/conf/rconcan /etc/nginx/sites-available/rconcan

    #Enlace simbólico
     sudo ln -sf /etc/nginx/sites-available/rconcan /etc/nginx/sites-enabled/


#Reinicia el servidor para aplicar la nueva configuración
     sudo systemctl restart nginx



#CONFIGURACIÓN SEGUNDO SITIO WEB
    sudo mkdir -p /var/www/rocio2_web/html

#Volvemos a asignar permisos esta vez al nuevo directorio
     sudo chown -R www-data:www-data /var/www/rocio2_web/html
     sudo chmod -R 755 /var/www/rocio2_web

#Creación del archivo y del enlace simbólico
    # sudo bash -c 'cat > /etc/nginx/sites-available/rconcan2 <<EOF
    #     server {
    #         listen 80;
    #         listen [::]:80;
    #         root /var/www/rocio2_web/html;
    #         index index.html index.htm index.nginx-debian.html;
    #         server_name rconcan2.com www.rconcan2.com;
    #         location / {
    #             try_files $uri $uri/ =404;
    #         }
    #     }
    # EOF'

    cp /vagrant/conf/rconcan2 /etc/nginx/sites-available/rconcan2

 #Enlace simbólico
    sudo ln -sf /etc/nginx/sites-available/rconcan2 /etc/nginx/sites-enabled/


#nos aseguramos que no va mostrar la página por defecto de Nginx
    sudo unlink /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx

#CONFIGURACIÓN PARA EL SERVIDOR FTPS EN DEBIAN
#Instalación de repositorios
    sudo apt-get update
    sudo apt-get -y install vsftpd


    #USUARIO

    # Crea el usuario de FTP y configura permisos
        sudo useradd -m rocio_user -s /bin/bash
        echo "rocio_user:deaw" | sudo chpasswd

    #Crea la carpeta en el home de Debian
        sudo mkdir -p /home/rocio_user/ftp

    #Permisos
        sudo chown -R rocio_user:rocio_user /home/rocio_user/ftp
        sudo chown -R rocio_user:rocio_user /var/www/rocio2_web/html


#Creación de los certificados de seguridad
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt
    cp /vagrant/conf/vsftpd.crt /etc/ssl/certs/vsftpd.crt
    cp /vagrant/conf/vsftpd.key /etc/ssl/private/vsftpd.key

#configuración del vsftpd
cp /vagrant/conf/vsftpd.conf /etc/vsftpd.conf


#Reinicia el servidor para aplicar la nueva configuración
sudo systemctl restart vsftpd


