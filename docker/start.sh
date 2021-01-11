#!/bin/sh

service supervisor start

gunicorn -b 0.0.0.0:8080 rooibos.wsgi:application --log-config docker/gunicorn-logging.conf
