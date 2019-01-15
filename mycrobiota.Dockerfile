FROM quay.io/shiltemann/galaxy-ireport:16.07

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "Streeklab Mycrobiota"

WORKDIR /galaxy-central

ADD mycrobiota/tools.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml

ADD mycrobiota/xy_plot.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/xy_plot/23657fcaaa5c/xy_plot/xy_plot.xml

ADD mycrobiota/reference/*.loc /galaxy-central/tool-data/
RUN mkdir /galaxy-central/tool-data/data/
ADD https://zenodo.org/record/2539387/files/HMP_silva.v35.pcr.align?download=1 /galaxy-central/tool-data/data/HMP_silva.v35.pcr.align
ADD https://zenodo.org/record/2539387/files/HMP_silva.v53.pcr.align?download=1 /galaxy-central/tool-data/data/HMP_silva.v53.pcr.align
ADD https://zenodo.org/record/2539387/files/HMPv3-v5_1369-1368?download=1 /galaxy-central/tool-data/data/HMPv3-v5_1369-1368
ADD https://zenodo.org/record/2539387/files/HMPv5-v3_1368-1369?download=1 /galaxy-central/tool-data/data/HMPv5-v3_1368-1369
ADD https://zenodo.org/record/2539387/files/silva.gold.align?download=1 /galaxy-central/tool-data/data/silva.gold.align
ADD https://zenodo.org/record/2539387/files/silva.nr_v119.kronatax?download=1 /galaxy-central/tool-data/data/silva.nr_v119.kronatax
ADD https://zenodo.org/record/2539387/files/silva.nr_v119.pcrv3v5.align?download=1 /galaxy-central/tool-data/data/silva.nr_v119.pcrv3v5.align
ADD https://zenodo.org/record/2539387/files/silva.nr_v119.tax?download=1 /galaxy-central/tool-data/data/silva.nr_v119.tax
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.Bogaert.align?download=1 /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.align
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.Bogaert.tax?download=1 /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.tax
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.V4.tax?download=1 /galaxy-central/tool-data/data/silva.nr_v123.V4.tax
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.V4pcr.align?download=1 /galaxy-central/tool-data/data/silva.nr_v123.V4pcr.align
ADD https://zenodo.org/record/2539387/files/silva.v4.fasta?download=1 /galaxy-central/tool-data/data/silva.v4.fasta/silva.v4.fasta

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]