#!/usr/bin/env bash

if [ "$(printf %c $1)" = '-' ]; then
  if [ "$(printf %s $1)" = '--debug' ] || [ "$(printf %s $2)" = '--debug' ]; then
    mv /etc/php.d/15-xdebug.ini.disabled /etc/php.d/15-xdebug.ini
    ip="$(awk 'END{print $1}' /etc/hosts)"
    echo "Modo de debug foi ativado no endereco $ip na porta 9000"
    echo "O IDE key (session id) é: DOCKERENV"
    echo "Aguarde até 30s para garantir que o container iniciou os serviços corretamente."
  fi

  if [ "$(printf %s $1)" = '--public-folder' ] || [ "$(printf %s $2)" = '--public-folder' ]; then
    sed -i 's#/var/www/html;#/var/www/html/public;#g' /etc/nginx/nginx.conf
    echo "Sua aplicação será iniciada com o NGINX usando a pasta public como raiz."
  fi
fi

echo "=============================================================================="
echo "     O PHP-FPM e o NGINX exibirão suas mensagens de erro nesta interface"
echo "=============================================================================="

php-fpm
nginx