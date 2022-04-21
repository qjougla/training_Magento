###############################################################################
## VARNISH

.PHONY: varnish-flush
varnish-flush:
	./run exec $(execArgs) varnish varnishadm ban 'req.url ~ .'

.PHONY: varnish-logs
varnish-logs:
	./run exec $(execArgs) varnish varnishlog

.PHONY: varnish-shell
varnish-shell:
	./run exec $(execArgs) varnish /bin/bash
