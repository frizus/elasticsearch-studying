setup: install-libs install-composer-scripts

install-libs:
	composer install

install-composer-scripts:
	composer run-script post-root-package-install
	composer run-script post-create-project-cmd

db:
	./artisan migrate

linter:
	./vendor/bin/php-cs-fixer fix .

test:
	# Тесты не написаны

lint: linter

.PHONY: test
