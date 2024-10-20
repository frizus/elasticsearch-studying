run:
	docker-compose up -d

copy-env:
	cp -n .env.default .env || true

setup: copy-env clear build
	docker-compose run --rm php bash -i -c "\
	make setup\
	"

build: copy-env
	docker-compose build

build-no-cache: copy-env
	docker-compose build --no-cache

down:
	docker-compose stop || true

clear:
	docker-compose down -v --remove-orphans || true

build-php:
	docker-compose build php

rebuild-php:
	docker-compose build --no-cache php

build-nginx:
	docker-compose build nginx

rebuild-nginx:
	docker-compose build --no-cache nginx

build-db:
	docker-compose build db

rebuild-db:
	docker-compose build --no-cache db

test:
	docker-compose run --rm php bash -i -c "\
	make test\
	"

connect-php:
	docker-compose exec -it php bash

connect-db:
	docker-compose exec -it db bash

connect-elastic-search:
	docker-compose exec -it elastic-search bash

restart: down up

connect-es: connect-elastic-search

install: setup

start: run

launch: run

compose: run

up: run

rebuild: build-no-cache

.PHONY: test