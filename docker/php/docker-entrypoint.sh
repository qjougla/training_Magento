#!/bin/bash

[ "$DEBUG" == "true" ] && set -x

# Ensure our Magento directory exists
mkdir -p $APP_ROOT

# ~/.composer directory volume is created with root if absent. Change ownership to app user
[ "$(stat -c '%U' /home/app/.composer/)" == "root" ] && chown $USER_ID:$USER_GID /home/app/.composer/

# Configure Sendmail if required
if [ "$ENABLE_SENDMAIL" == "true" ]; then
    /etc/init.d/sendmail start
fi

# Enable PHP extensions
PHP_EXT_DIR=/usr/local/etc/php/conf.d
PHP_EXT_COM_ON=docker-php-ext-enable
[ -d ${PHP_EXT_DIR} ] && rm -f ${PHP_EXT_DIR}/docker-php-ext-*.ini
if [ -x "$(command -v ${PHP_EXT_COM_ON})" ] && [ ! -z "${PHP_EXTENSIONS}" ]; then
      ${PHP_EXT_COM_ON} ${PHP_EXTENSIONS}
fi

# Configure PHP-FPM
[ ! -z "${MAGENTO_RUN_MODE}" ] && sed -i "s/!MAGENTO_RUN_MODE!/${MAGENTO_RUN_MODE}/" /usr/local/etc/php-fpm.conf

if [ "$XDEBUG" == 1 ]; then
  docker-php-ext-enable xdebug
else
  rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

exec "$@"
