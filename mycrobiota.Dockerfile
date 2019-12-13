FROM quay.io/shiltemann/galaxy-ireport:16.07

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "MYcrobiota"

# Fix conda
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL "True"
ENV GALAXY_CONFIG_CONDA_AUTO_INIT "True"
ENV GALAXY_CONFIG_CONDA_ENSURE_CHANNELS "iuc,conda-forge,bioconda,defaults"

WORKDIR /galaxy-central

# Install workflows
RUN pip install --upgrade ephemeris

ADD mycrobiota/workflows $GALAXY_HOME/workflows/
RUN workflow-to-tools --output-file $GALAXY_ROOT/tools.yaml --panel_label workflow-tools --workflow `ls -p -d $GALAXY_HOME/workflows/* | grep -v -E "/$" | tr '\n' ' '`

ADD install-tools.sh $GALAXY_HOME/install-tools.sh
RUN $GALAXY_HOME/install-tools.sh

# Install Tools
ADD install-workflows.sh $GALAXY_HOME/install-workflows.sh
RUN $GALAXY_HOME/install-workflows.sh

## manually install these ones
ADD mycrobiota/xy_plot_tool/xy_plot.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/xy_plot/ecb437f1d298/xy_plot/xy_plot.xml
ADD mycrobiota/xy_plot_tool/r_wrapper.sh /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/xy_plot/ecb437f1d298/xy_plot/r_wrapper.sh




# Reference Data
## copy loc file
ADD mycrobiota/reference/*.loc /galaxy-central/tool-data/
RUN mkdir /galaxy-central/tool-data/data/

## download reference data from zenodo
ADD https://zenodo.org/record/2539387/files/HMP_silva.v35.pcr.align /galaxy-central/tool-data/data/HMP_silva.v35.pcr.align
ADD https://zenodo.org/record/2539387/files/HMP_silva.v53.pcr.align /galaxy-central/tool-data/data/HMP_silva.v53.pcr.align
ADD https://zenodo.org/record/2539387/files/HMPv3-v5_1369-1368 /galaxy-central/tool-data/data/HMPv3-v5_1369-1368
ADD https://zenodo.org/record/2539387/files/HMPv5-v3_1368-1369 /galaxy-central/tool-data/data/HMPv5-v3_1368-1369
ADD https://zenodo.org/record/2539387/files/silva.gold.align /galaxy-central/tool-data/data/silva.gold.align
ADD https://zenodo.org/record/2539387/files/silva.nr_v119.kronatax /galaxy-central/tool-data/data/silva.nr_v119.kronatax
ADD https://zenodo.org/record/2539387/files/silva.nr_v119.pcrv3v5.align /galaxy-central/tool-data/data/silva.nr_v119.pcrv3v5.align
ADD https://zenodo.org/record/2539387/files/silva.nr_v119.tax /galaxy-central/tool-data/data/silva.nr_v119.tax
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.Bogaert.align /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.align
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.Bogaert.tax /galaxy-central/tool-data/data/silva.nr_v123.Bogaert.tax
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.V4.tax /galaxy-central/tool-data/data/silva.nr_v123.V4.tax
ADD https://zenodo.org/record/2539387/files/silva.nr_v123.V4pcr.align /galaxy-central/tool-data/data/silva.nr_v123.V4pcr.align
ADD https://zenodo.org/record/2539387/files/silva.v4.fasta /galaxy-central/tool-data/data/silva.v4.fasta/silva.v4.fasta

ENV TERM "xterm"

ADD mycrobiota/reference/mothur_aligndb.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_aligndb.loc
ADD mycrobiota/reference/mothur_lookup.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_lookup.loc
ADD mycrobiota/reference/mothur_map.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_map.loc
ADD mycrobiota/reference/mothur_taxonomy.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/5d134e0b31fd/mothur_taxonomy.loc

ENV GALAXY_CONFIG_CLEANUP_JOB "onsuccess"

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]
