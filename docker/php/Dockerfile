ARG PHP_VERSION

FROM magento/magento-cloud-docker-php:${PHP_VERSION}

RUN wget -q https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 -O /usr/local/bin/mhsendmail \
 && chmod +x /usr/local/bin/mhsendmail

RUN apt-get update \
 && apt-get install -y \
    git \
    curl \
    wget \
    cron \
    default-mysql-client \
    pv \
    redis-tools \
    unzip \
    pv \
    vim \
    netcat \
    rsync \
    openssh-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
 && apt-get install -y nodejs \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g \
    grunt-cli \
    phantomjs-prebuilt

RUN curl -sL -o /usr/bin/cachetool https://github.com/gordalina/cachetool/releases/latest/download/cachetool.phar \
 && chmod +x /usr/bin/cachetool

# Custom volume for Magento code (we don't use standard /app)
ARG APP_ROOT
VOLUME ${APP_ROOT}

COPY zz-zz-custom.ini /usr/local/etc/php/conf.d/zz-zz-custom.ini
COPY zz-mail.ini /usr/local/etc/php/conf.d/zz-mail.ini

COPY php-fpm.conf /usr/local/etc/php-fpm.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Substitute in php.ini values
ARG PHP_MEMORY_LIMIT
RUN sed -i "s/!PHP_MEMORY_LIMIT!/${PHP_MEMORY_LIMIT}/" /usr/local/etc/php/conf.d/zz-magento.ini

# Composer
ARG COMPOSER_VERSION
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --${COMPOSER_VERSION}

WORKDIR ${APP_ROOT}

RUN apt-get update \
 && apt-get install less
