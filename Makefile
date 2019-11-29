ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: lint _update-phplint
CURRENT_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

VERSION = 7.3
IGNORES = ./vendor/*

lint: _update-phplint
	docker run -it --rm cytopia/phplint:${VERSION} -i ${IGNORES} '*.php'

_update-phplint:
	docker pull cytopia/phplint:${VERSION}
