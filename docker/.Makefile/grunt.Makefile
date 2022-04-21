###############################################################################
## GRUNT

.PHONY: grunt-configure
grunt-configure: ## [Grunt] configure grunt for an empty Magento project
	./run exec $(execArgs) --user www-data grunt /scripts/configure.sh

.PHONY: grunt-clean
grunt-clean: ## [Grunt] Run grunt clean
	./run exec $(execArgs) --user www-data grunt /usr/local/bin/grunt clean

.PHONY: grunt-exec
grunt-exec: ## [Grunt] Run grunt exec
	./run exec $(execArgs) --user www-data grunt /usr/local/bin/grunt exec

.PHONY: grunt-watch
grunt-watch: ## [Grunt] Run grunt watch
	./run exec $(execArgs) --user www-data grunt /usr/local/bin/grunt watch

.PHONY: grunt-less
grunt-less: ## [Grunt] Run grunt less
	./run exec $(execArgs) --user www-data grunt /usr/local/bin/grunt less

.PHONY: grunt-refresh
grunt-refresh: ## [Grunt] Run grunt refresh
	./run exec $(execArgs) --user www-data grunt /usr/local/bin/grunt refresh
