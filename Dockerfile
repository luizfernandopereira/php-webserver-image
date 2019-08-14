FROM fedora

RUN dnf update -y \
    && dnf install php-pear \
    php-devel \
    make \
    gcc \
    gcc-c++ -y

RUN mkdir /install-path
COPY ./*.rpm /install-path/

RUN dnf install ./install-path/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm \
    ./install-path/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm -y

RUN echo /usr/lib/oracle/19.3/client64 | \
    C_INCLUDE_PATH=/usr/include/oracle/19.3/client64 pecl install oci8

FROM fedora

LABEL maintainer="Luiz Fernando Pereira <luizfernandopereira@outlook.com.br>"
LABEL company="Alternativa Informática <marcelo@altinfo.com.br>"

COPY ./oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm /install-path/

RUN dnf install /install-path/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm -y

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
    php-pgsql \
    php-pecl-xdebug \
    nginx -y \
    && dnf clean all

ENV TIMEZONE=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

RUN rm -Rf /install-path
RUN rm /etc/php.d/15-xdebug.ini
COPY xdebug.ini /etc/php.d/15-xdebug.ini.disabled
COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /etc/php.ini
COPY www.conf /etc/php-fpm.d/www.conf
COPY ./fail-pages/*.html /usr/share/nginx/html/
COPY --from=0 /usr/lib64/php/modules/oci8.so /usr/lib64/php/modules/oci8.so
COPY oracle-extension.ini /etc/php.d/20-oci8.ini

RUN chmod +x /usr/lib64/php/modules/oci8.so

COPY entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh \
    && mkdir /run/php-fpm && mkdir /var/www/test
COPY ./test/index.php /var/www/test/

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl --fail http://localhost/test || exit 1

EXPOSE 80
EXPOSE 9000

ENTRYPOINT [ "/usr/sbin/entrypoint.sh" ]