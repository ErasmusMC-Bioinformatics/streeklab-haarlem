FROM quay.io/shiltemann/galaxy-ireport:16.07

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "Streeklab Mycrobiota"

# Fix conda
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL "True"
ENV GALAXY_CONFIG_CONDA_AUTO_INIT "True"
ENV GALAXY_CONFIG_CONDA_ENSURE_CHANNELS "iuc,conda-forge,bioconda,defaults"

WORKDIR /galaxy-central

ADD mycrobiota/tools.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml

ADD mycrobiota/xy_plot.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/xy_plot/23657fcaaa5c/xy_plot/xy_plot.xml

ADD mycrobiota/reference/*.loc /galaxy-central/tool-data/
RUN mkdir /galaxy-central/tool-data/data/

#ADD https://zenodo.org/record/2539387/files/HMP_silva.v35.pcr.align /galaxy-central/tool-data/data/HMP_silva.v35.pcr.align
#ADD https://zenodo.org/record/2539387/files/HMP_silva.v53.pcr.align /galaxy-central/tool-data/data/HMP_silva.v53.pcr.align
#ADD https://zenodo.org/record/2539387/files/HMPv3-v5_1369-1368 /galaxy-central/tool-data/data/HMPv3-v5_1369-1368
#ADD https://zenodo.org/record/2539387/files/HMPv5-v3_1368-1369 /galaxy-central/tool-data/data/HMPv5-v3_1368-1369
#ADD https://zenodo.org/record/2539387/files/silva.gold.align /galaxy-central/tool-data/data/silva.gold.align
#ADD https://zenodo.org/record/2539387/files/silva.nr_v119.kronatax /galaxy-central/tool-data/data/silva.nr_v119.kronatax
#ADD https://zenodo.org/record/2539387/files/silva.nr_v119.pcrv3v5.align /galaxy-central/tool-data/data/silva.nr_v119.pcrv3v5.align
#ADD https://zenodo.org/record/2539387/files/silva.nr_v119.tax /galaxy-central/tool-data/data/silva.nr_v119.tax
#ADD https://zenodo.org/record/2539387/files/silva.nr_v123.Bogaert.align /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.align
#ADD https://zenodo.org/record/2539387/files/silva.nr_v123.Bogaert.tax /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.tax
#ADD https://zenodo.org/record/2539387/files/silva.nr_v123.V4.tax /galaxy-central/tool-data/data/silva.nr_v123.V4.tax
#ADD https://zenodo.org/record/2539387/files/silva.nr_v123.V4pcr.align /galaxy-central/tool-data/data/silva.nr_v123.V4pcr.align
#ADD https://zenodo.org/record/2539387/files/silva.v4.fasta /galaxy-central/tool-data/data/silva.v4.fasta/silva.v4.fasta

ADD mycrobiota/zenodo/HMP_silva.v35.pcr.align /galaxy-central/tool-data/data/HMP_silva.v35.pcr.align
ADD mycrobiota/zenodo/HMP_silva.v53.pcr.align /galaxy-central/tool-data/data/HMP_silva.v53.pcr.align
ADD mycrobiota/zenodo/HMPv3-v5_1369-1368 /galaxy-central/tool-data/data/HMPv3-v5_1369-1368
ADD mycrobiota/zenodo/HMPv5-v3_1368-1369 /galaxy-central/tool-data/data/HMPv5-v3_1368-1369
ADD mycrobiota/zenodo/silva.gold.align /galaxy-central/tool-data/data/silva.gold.align
ADD mycrobiota/zenodo/silva.nr_v119.kronatax /galaxy-central/tool-data/data/silva.nr_v119.kronatax
ADD mycrobiota/zenodo/silva.nr_v119.pcrv3v5.align /galaxy-central/tool-data/data/silva.nr_v119.pcrv3v5.align
ADD mycrobiota/zenodo/silva.nr_v119.tax /galaxy-central/tool-data/data/silva.nr_v119.tax
ADD mycrobiota/zenodo/silva.nr_v123.Bogaert.align /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.align
ADD mycrobiota/zenodo/silva.nr_v123.Bogaert.tax /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.tax
ADD mycrobiota/zenodo/silva.nr_v123.V4.tax /galaxy-central/tool-data/data/silva.nr_v123.V4.tax
ADD mycrobiota/zenodo/files/silva.nr_v123.V4pcr.align /galaxy-central/tool-data/data/silva.nr_v123.V4pcr.align
ADD mycrobiota/zenodo/files/silva.v4.fasta /galaxy-central/tool-data/data/silva.v4.fasta/silva.v4.fasta

ENV TERM "xterm"

ADD mycrobiota/reference/mothur_aligndb.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_aligndb.loc
ADD mycrobiota/reference/mothur_lookup.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_lookup.loc
ADD mycrobiota/reference/mothur_map.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_map.loc
ADD mycrobiota/reference/mothur_taxonomy.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_taxonomy.loc

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]