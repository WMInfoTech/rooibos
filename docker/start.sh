#!/bin/sh

# make sure db environment variables get picked up by suprvisord for workers
echo 'export DB_HOST='$DB_HOST > /etc/default/supervisor
echo 'export DB_USER='$DB_USER >> /etc/default/supervisor
echo 'export DB_PASSWORD='$DB_PASSWORD >> /etc/default/supervisor
echo 'export DB_NAME='$DB_NAME >> /etc/default/supervisor
echo 'export CELERY_BROKER_URL='$CELERY_BROKER_URL >> /etc/default/supervisor

service supervisor start

gunicorn -b 0.0.0.0:8080 rooibos.wsgi:application --log-config docker/gunicorn-logging.conf
