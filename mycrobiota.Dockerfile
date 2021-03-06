FROM quay.io/shiltemann/galaxy-ireport:16.07

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "MYcrobiota 2020-02-02"

# Fix conda
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL "True"
ENV GALAXY_CONFIG_CONDA_AUTO_INIT "True"
ENV GALAXY_CONFIG_CONDA_ENSURE_CHANNELS "iuc,conda-forge,bioconda,defaults"
ENV GALAXY_CONFIG_INSTALL_DATABASE_CONNECTION "sqlite:///tools-database.sqlite?isolation_level=IMMEDIATE"

WORKDIR /galaxy-central

RUN apt-get update; apt-get install -y libreadline-dev

# Install tools and workflows
ADD mycrobiota/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD mycrobiota/tools.yaml $GALAXY_ROOT/tools.yaml
ADD install-tools-workflows.sh $GALAXY_HOME/install-tools-workflows.sh
ADD mycrobiota/workflows $GALAXY_HOME/workflows/
RUN chmod a+rwx $GALAXY_HOME/install-tools-workflows.sh

RUN $GALAXY_HOME/install-tools-workflows.sh

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

ADD mycrobiota/reference/mothur_aligndb.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/152ae632ab19/mothur_aligndb.loc
ADD mycrobiota/reference/mothur_lookup.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/152ae632ab19/mothur_lookup.loc
ADD mycrobiota/reference/mothur_map.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/152ae632ab19/mothur_map.loc
ADD mycrobiota/reference/mothur_taxonomy.loc /galaxy-central/tool-data/toolshed.g2.bx.psu.edu/repos/iuc/mothur_align_seqs/152ae632ab19/mothur_taxonomy.loc

# Fix libreadline dependency manually
ADD mycrobiota/libreadline.so.7 /lib/x86_64-linux-gnu/libreadline.so.7.0
RUN ln -s /lib/x86_64-linux-gnu/libreadline.so.7.0 /lib/x86_64-linux-gnu/libreadline.so.7

ADD mycrobiota/libtinfo.so.5.9 /lib/x86_64-linux-gnu/libtinfo.so.5.9
RUN rm /lib/x86_64-linux-gnu/libtinfo.so.5; ln -s /lib/x86_64-linux-gnu/libtinfo.so.5.9 /lib/x86_64-linux-gnu/libtinfo.so.5

# fix bug in mothur table_count file type
# with sed, galaxy-central is not a git repo...
RUN sed -i '738d' /galaxy-central/lib/galaxy/datatypes/mothur.py

ENV GALAXY_CONFIG_CLEANUP_JOB "onsuccess"

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]
