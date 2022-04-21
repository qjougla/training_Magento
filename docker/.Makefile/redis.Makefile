###############################################################################
## REDIS

.PHONY: redis-flush-all
redis-flush-all:
	./run exec $(execArgs) redis redis-cli flushall

.PHONY: redis-flush-db
redis-flush-db:
	test ! -z "$(db)" || { echo >&2 "Misding 'db' param."; exit 1; }
	./run exec $(execArgs) redis redis-cli -n $(db) flushdb
