FROM solr:7.7.3-slim

RUN mkdir -p /opt/solr/data/mdid

COPY . /opt/solr/data/mdid

ENV SOLR_HEAP=2048m

EXPOSE 8983
