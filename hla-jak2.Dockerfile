FROM bgruening/galaxy-stable:18.09

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "HLA-JAK2"

WORKDIR /galaxy-central

# Install Tools
ADD hla-typing/tools.yaml $GALAXY_ROOT/hla-tools.yaml
RUN install-tools $GALAXY_ROOT/hla-tools.yaml

ADD jak2-mutation/tools.yaml $GALAXY_ROOT/jak2-tools.yaml
RUN install-tools $GALAXY_ROOT/jak2-tools.yaml

# Install Workflows
ADD hla-typing/workflows $GALAXY_HOME/workflows/
ADD jak2-mutation/workflows $GALAXY_HOME/workflows/
ADD install-workflows.sh $GALAXY_HOME/install-workflows.sh
RUN $GALAXY_HOME/install-workflows.sh


VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]
