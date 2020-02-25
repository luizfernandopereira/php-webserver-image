FROM fedora

LABEL maintainer="Luiz Fernando Pereira <luizfernandopereira@outlook.com.br>"

RUN dnf install php \
    php-cli \
    php-common \
    php-pdo \
    php-mysqlnd \
    php-pgsql \
    php-mbstring \
    php-xml \
    php-zip \
    php-json \
    php-gd \
    php-soap \
    php-intl \
    php-pear \
    php-pecl-xdebug \
    php-ldap \
    nginx -y \
    && dnf clean all

ENV TIMEZONE=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

RUN rm /etc/php.d/15-xdebug.ini
COPY xdebug.ini /etc/php.d/15-xdebug.ini.disabled
COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /etc/php.ini
COPY www.conf /etc/php-fpm.d/www.conf
COPY ./fail-pages/*.html /usr/share/nginx/html/

COPY entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh \
    && mkdir /run/php-fpm && mkdir /var/www/test
    
RUN mkdir -p /var/lib/php/session
RUN chown -R nginx:nginx /var/lib/php
COPY ./test/index.php /var/www/test/

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost/test || exit 1

EXPOSE 80
EXPOSE 9000

ENTRYPOINT [ "/usr/sbin/entrypoint.sh" ]