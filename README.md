# GRAV Base #

Base docker image for running GRAV + Admin

### Contents ###

The image runs : 
- Nginx
- PHP 7.2 & PHP-FPM

PHP modules : 
- CURL
- JSON
- Ctype
- DOM
- GD
- MBString
- OpenSSL
- PDO MySQL
- Session
- Simple XML
- XML
- Zip
- Opcache
- Memcached

Image based on `trafex/alpine-nginx-php7`.

### USAGE ###

#### Conf files ####

Configuration files are located at : 

Nginx : `/etc/nginx/nginx.conf`
PHP-FPM pool : `/etc/php7/php-fpm.d/zz-custom.conf`
PHP : `/etc/php7/conf.d/zz-custom.ini`
Supervisord : `/etc/supervisor/conf.d/supervisord.conf`

Nginx root is set as `/var/www/grav-admin/`.

#### Getting content into container ####

Content can be copied or mounted into container with `var/www/grav-admin` as its base :

copied through Dockefile

    FROM aerlaut/grav-base
    COPY . /var/www/grav-admin

or mounted

    docker run -v <src>/user:/var/www/grav-admin/user -p 80:80 aerlaut/grav-base

Nginx and PHP-FPM are set to run as `root:dev`. The group `dev` has ID `1024`. Folder on host can be mounted with group `1024` to enable editing from both the container and the host.

#### Accessing admin panel ####

Admin panel can be accessed from `localhost/admin`.