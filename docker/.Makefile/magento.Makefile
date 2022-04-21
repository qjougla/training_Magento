###############################################################################
## MAGENTO

.PHONY: magento-setup-install
magento-setup-install: ## [Magento] Launch magento installer
	./run exec $(execArgs) --user www-data -e MAGENTO_URL=${APP_URL} php /scripts/install-magento

.PHONY: magento-install
magento-install: ## [Docker] Install the stack
	./run exec $(execArgs) --user www-data php /scripts/create-magento-project
	$(MAKE) magento-setup-install
	./run exec $(execArgs) --user www-data php /${APP_ROOT}/bin/magento cron:install

.PHONY: magento-install-sampledata
magento-install-sampledata: ## [Magento] Install sample data
	./run exec $(execArgs) --user www-data php /scripts/install-sample-data

.PHONY: magento-cache-flush
magento-cache-flush: ## [Magento] Flush cache
	./run exec $(execArgs) --user www-data php /${APP_ROOT}/bin/magento cache:flush

.PHONY: magento-setup-upgrade
magento-setup-upgrade: ## [Magento] Run setup:upgrade
	./run exec $(execArgs) --user www-data php /${APP_ROOT}/bin/magento setup:upgrade

.PHONY: magento-reindex
magento-reindex: ## [Magento] Reindex all
	./run exec $(execArgs) --user www-data php /${APP_ROOT}/bin/magento indexer:reindex

.PHONY: magento-bin-exec
magento-bin-exec: ## [Magento] Run a bin/magento command
	./run exec $(execArgs) --user www-data php /${APP_ROOT}/bin/magento $(magentoCmd) $(magentoCmdArgs)

.PHONY: magento-phpunit
magento-phpunit: ## [Magento] Launch PHPUnit
	./run exec $(execArgs) --user www-data php /${APP_ROOT}/vendor/phpunit/phpunit/phpunit -c /magento_code/app/code/PROJECT/PhpUnit/etc/phpunit.xml

.PHONY: magento-import-ref-db
magento-import-ref-db:
	rsync -avL ${REFERENCE_DUMP} ../magento_source_code/
	./run exec $(execArgs) --user www-data php /scripts/import-magento-db
