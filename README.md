# DEAW_servWeb_nginx

## Descripción
Instalación y configuración de servidor web Nginx

## Primera página web
Luego de seguir la indicaciones del pdf obtuve la primera página web, estos pasos se recogen en provision.sh y se crean en el directorio rocio_web, con un enlace simbólico llamado rconcan.
<img src="img/img1.png" alt="PáginaWeb1"/>

## Segunda página web
Para esta lo hice con la transerencia de archivos mediante el cliente FTPS, FileZilla.
Creé el usuario rocio_user, le asigné una contraseña y le di permisos sobre el directorio rocio2_web (enlace simbólico rconcan).

<img src="img/img2.png" alt="Conexion1"/>
<img src="img/img3.png" alt="Conexion2"/>
<img src="img/img4.png" alt="Conexion3"/>
<img src="img/img5.png" alt="PaginaWeb2"/>


# Cuestiones finales

**¿Qué pasa si no hago el link simbólico entre sites-available y sites-enabled de mi sitio web?**
Nginx no va a cargar la configuración del sitio web ya que, en sites-available se guarda la configuración de todos los sitios web, estén activos o no, en cambio sites-enabled sirve para que el servidor, Nginx, lea las configuraciones activas de los sitios que tiene que mostrar, por tanto si no se crea el link no va a leer la configuración y probablemente muestre la predeterminada de Nginx.

**¿Qué pasa si no le doy los permisos adecuados a /var/www/nombre_web?**
En el caso de que no le des los permisos suficientes, Nginx no podrá acceder a los archivos del sitio web y mostrará errores como el "403 Forbidden".
Otro caso es que le demos demasiados permisos, como el 777, y que se genere un riesgo de seguridad.
