#!/bin/bash

set -euo pipefail

docker-compose -f docker-compose.yml -f docker-compose.dev.yml build --force-rm db redis ganache
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --no-start db redis ganache
docker restart multisig-transaction-service_db_1 multisig-transaction-service_redis_1 multisig-transaction-service_ganache_1
sleep 2
DJANGO_SETTINGS_MODULE=config.settings.test DJANGO_DOT_ENV_FILE=.env_local python manage.py check
DJANGO_SETTINGS_MODULE=config.settings.test DJANGO_DOT_ENV_FILE=.env_local pytest
