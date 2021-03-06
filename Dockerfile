FROM python:3.8-buster

LABEL org.label-schema.name="MDID" \
      org.label-schema.description="Basic intallation of MDID" \
      org.label-schema.schema-version="1.0"

ENV PYTHONUNBUFFERED=1

HEALTHCHECK CMD curl -f http://localhost:8080/ || exit 1

RUN apt-get update \
    && apt-get install -y --no-install-recommends libjpeg-dev libfreetype6-dev \
    libmariadb-dev python3-dev libldap2-dev libsasl2-dev supervisor \
    ffmpeg openjdk-11-jre-headless libssl-dev poppler-utils cron \
    && ln -s -f /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib/ \
    && ln -s -f /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/ \
    && ln -s -f /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib/ \
    && useradd mdid \
    && rm -Rf /var/lib/apt/lists

# Actually start installing MDID itself
COPY --chown=mdid . /opt/mdid
WORKDIR /opt/mdid

ENV DJANGO_SETTINGS_MODULE="rooibos_settings.local_settings"
ENV PYTHONPATH="/opt/mdid:/opt/mdid/rooibos"

# Install python packages and cleanup
RUN pip install --no-cache-dir --upgrade -r requirements.txt \
    && mkdir /opt/mdid/log /opt/mdid/scratch /opt/mdid/storage /opt/mdid/static \
    && mv rooibos_settings/base_docker.py rooibos_settings/base.py \
    && mv rooibos_settings/docker_template.py rooibos_settings/local_settings.py \
    && python manage.py collectstatic --noinput \
    && apt-get purge -y build-essential autoconf automake gcc g++ \
    && apt-get autoremove -y

# set up cron jobs
COPY ./docker/wrapper.sh /opt/mdid
COPY ./docker/crontab /opt/mdid
RUN crontab -u www-data /opt/mdid/crontab

COPY rooibos_settings/supervisor.conf /etc/supervisor/conf.d/mdid.conf
RUN chown mdid:mdid log

COPY ./docker/start.sh /opt/mdid

EXPOSE 8080
CMD ["/opt/mdid/start.sh"]
