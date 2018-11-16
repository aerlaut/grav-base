FROM alpine:3.8

LABEL Maintainer="Anugerah Erlaut <aerlaut@live.com>" \
      Description="Alpine-based container for Grav"

# Add User and group
RUN addgroup -g 1024 dev && \
    adduser -D -u 500 -G dev dev

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zz-custom.conf
COPY config/php.ini /etc/php7/conf.d/zz-custom.ini

# Configure supervisord 
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install packages
RUN apk --no-cache add php7 \
    php7-curl \
    php7-json \
    php7-ctype \
    php7-dom \
    php7-gd \
    php7-mbstring \
    php7-openssl \
    php7-session \
    php7-simplexml \
    php7-xml \
    php7-zip \
    php7-fpm \
    php7-opcache \
    php7-memcached \
    nginx \
    supervisor \
    curl \
    git

# Installing Grav
RUN mkdir /var/www/html && \
    wget -O /usr/local/share/grav.zip https://getgrav.org/download/core/grav-admin/latest && \
    unzip -q /usr/local/share/grav.zip -d /var/www/ && \
    rm /usr/local/share/grav.zip

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
