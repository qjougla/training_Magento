###############################################################################
## CAPISTRANO

.PHONY: cap-shell
cap-shell: ## [Capistrano] Launch bash on capistrano container
	docker-compose run --rm --user app capistrano /bin/bash -c 'cd /capistrano; /bin/bash'

.PHONY: cap-exec
cap-exec: ## [Capistrano] Execute command in a capistrano container
	docker-compose run --rm --user app capistrano /bin/bash -c 'cd /capistrano; /bin/bash -c "$(cmd)"'

.PHONY: cap-rebuild
cap-rebuild: ## [Capistrano] Rebuild capistrano container
	docker-compose build capistrano