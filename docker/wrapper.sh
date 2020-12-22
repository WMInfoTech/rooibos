set -x
export PYTHONPATH="/opt/mdid:/opt/mdid/rooibos"
export DJANGO_SETTINGS_MODULE="rooibos_settings.local_settings"
django-admin $@
