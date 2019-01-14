FROM bgruening/galaxy-stable:16.07

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "Streeklab Mycrobiota"

WORKDIR /galaxy-central

ADD mycrobiota/tools.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]