NAME    := Magento2
VERSION := 0.1.0
TARGETS := $(MAKEFILE_LIST)
SHELL   := /bin/bash

USER_ID := $(shell id -u)
USER_GID := $(shell id -g)
$(shell test -f .env > /dev/null 2>&1 || sed -e s/@USER_ID@/${USER_ID}/ -e s/@USER_GID@/${USER_GID}/ .env.sample > .env)

include .env
export $(shell grep -v '^\#' .env | sed 's/=.*//')

ifeq ("","$(strip ${APP_LOCAL_ROOT})")
   $(error Missing APP_LOCAL_ROOT)
endif
ifeq ($(wildcard ${APP_LOCAL_ROOT}/.),)
   $(error Invalid APP_LOCAL_ROOT (${APP_LOCAL_ROOT}))
endif

.PHONY: help
help: ## [Help] This help
	@grep -E '^[2a-zA-Z_-]+:.*?## .*$$' $(TARGETS) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: env
env:
	@env | sort

.PHONY: checkreq
checkreq:
	@./scripts/check-requirements.sh

include .Makefile/capistrano.Makefile
include .Makefile/magento.Makefile
include .Makefile/redis.Makefile
include .Makefile/selenium.Makefile
include .Makefile/varnish.Makefile
include .Makefile/grunt.Makefile

###############################################################################
## DOCKER

.PHONY: up
up: ## [Docker] Start the containers in foreground
	./run up $(args)

.PHONY: start
start: ## [Docker] Alias of make up
	$(MAKE) up

.PHONY: upd
upd: ## [Docker] Start the containers in background
	./run up -d $(args)

.PHONY: startd
startd: ## [Docker] Alias of make upd
	$(MAKE) upd

.PHONY: build
build: ## [Docker] Build the containers
	./run build

.PHONY: stop
stop: ## [Docker] Stop the containers
	./run stop $(service)

.PHONY: down
down: ## [Docker] Stop and destroy the containers and attached networks
	./run down $(args)

.PHONY: restartd
restartd: ## [Docker] Restart the containers detached
	$(MAKE) stop service=$(service)
	$(MAKE) upd

.PHONY: destroy
destroy: ## [Docker] Remove the containers
	docker-compose kill && docker-compose rm -f

.PHONY: nuke
nuke: ## [Docker] Stop and destroy the containers and attached networks + volumes
	docker-compose down -v --rmi local --remove-orphans

.PHONY: config
config: ## [Docker] Dump docker-compose configuration
	./run config

.PHONY: ps
ps: ## [Docker] Show running containers
	./run ps

.PHONY: logs
logs: ## [Docker] Show output of containers
	./run logs $(service)

.PHONY: logs-follow
logs-follow: ## [Docker] Show output of containers (and follow)
	./run logs -f --tail=50 $(service)

.PHONY: pull
pull: ## [Docker] Pull containers images
	./run pull || true

.PHONY: bash
bash: ## [Magento] Launch bash on web container as magento user
	./run exec $(execArgs) --user www-data php /bin/bash

.PHONY: bash-exec
bash-exec: ## [Magento] Launch bash on web container as magento user
	./run exec $(execArgs) --user www-data php /bin/bash '$(cmd)'

.PHONY: bash-root
bash-root: ## [Magento] Launch bash on web container as root user
	./run exec $(execArgs) --user root php /bin/bash

.PHONY: bash-root-exec
bash-root-exec: ## [Magento] Launch bash on web container as root user
	./run exec $(execArgs) --user root php /bin/bash -c '$(cmd)'

.PHONY: sql
sql:
	./run exec $(execArgs) db mysql -uroot -proot magento

.PHONY: sqldump
sqldump: DUMP_FILE=${COMPOSE_PROJECT_NAME}_$$(date +%F_%H-%M-%S).sql.gz
sqldump:
	./run exec $(execArgs) db mysqldump -uroot -proot magento | gzip > ${DUMP_FILE}

.PHONY: sqldump-simple
sqldump-simple:
	./run exec -T $(execArgs) php /scripts/dump-magento-db

.PHONY: composer
composer: ## [Composer]
	./run exec $(execArgs) --user www-data php 'composer $(cmd)'

.PHONY: xdebug-enable
xdebug-enable: ## [Enable Xdebug]
	sed -i '' 's/XDEBUG=0/XDEBUG=1/' .env > /dev/null 2>&1

.PHONY: xdebug-disable
xdebug-disable: ## [Enable Xdebug]
	sed -i '' 's/XDEBUG=1/XDEBUG=0/' .env > /dev/null 2>&1
