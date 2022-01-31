#!/usr/bin/env bash

if [ "$(printf %c $1)" = '-' ]; then
  if [ "$(printf %s $1)" = '--debug' ] || [ "$(printf %s $2)" = '--debug' ]; then
    mv /etc/php.d/15-xdebug.ini.disabled /etc/php.d/15-xdebug.ini
    ip="$(awk 'END{print $1}' /etc/hosts)"

    if [ -z ${XDEBUG_KEY+x} ]; then
      XDEBUG_KEY="DOCKERENV"
    fi

    echo "Debug mode is active on $ip on port 9000"
    echo "The IDE key (session id) is: $XDEBUG_KEY"
    echo "Wait until 30 seconds while the services are started."
  fi

  if [ "$(printf %s $1)" = '--public-folder' ] || [ "$(printf %s $2)" = '--public-folder' ]; then
    sed -i 's#/var/www/html;#/var/www/html/public;#g' /etc/nginx/nginx.conf
    echo "The aplication will be hosted with NGINX using the public folder as root."
  fi
fi

if [ -n "$TIMEZONE" ]; then
  ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone
fi


echo "=============================================================================="
echo "     The PHP-FPM and NGINX will show the logs messages on this interface"
echo "=============================================================================="

php-fpm
nginx