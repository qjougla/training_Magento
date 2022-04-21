###############################################################################
## SELENIUM

selenium-%: export COMPOSE_FILE=docker-compose.yml:docker-compose.selenium.yml

.PHONY: selenium-start
selenium-start: ## [Selenium] Start selenium container
	./run up -d --scale selenium=1

.PHONY: selenium-restart
selenium-restart: ## [Selenium] Restart selenium container
	yes | ./run rm -sv selenium
	$(MAKE) start-selenium

.PHONY: selenium-shell
selenium-shell: ## [Selenium] Launch bash in selenium container
	./run run --rm --user selenium selenium /bin/bash -c 'cd /selenium; /bin/bash'

.PHONY: selenium-exec
selenium-exec: ## [Selenium] Execute command in the selenium container
	./run run --rm --user selenium selenium /bin/bash -c 'cd /selenium; /bin/bash -c "$(cmd)"'

.PHONY: selenium-rebuild
selenium-rebuild: ## [Selenium] Rebuild selenium container
	./run build selenium