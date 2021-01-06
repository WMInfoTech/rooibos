FROM solr:7.7-slim

RUN mkdir -p /opt/solr/server/solr/rooibos

COPY --chown=solr . /opt/solr/server/solr/rooibos

ENV SOLR_HEAP=2048m

EXPOSE 8983
