FROM bgruening/galaxy-stable:18.09

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

# Fix conda
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL "True"
ENV GALAXY_CONFIG_CONDA_AUTO_INIT "True"
ENV GALAXY_CONFIG_CONDA_ENSURE_CHANNELS "iuc,conda-forge,bioconda,defaults"

WORKDIR /galaxy-central

# add Tools
ADD hla-typing/tools.yaml $GALAXY_ROOT/tools.yaml

# add Workflows
ADD hla-typing/workflows $GALAXY_HOME/workflows/
ADD jak2-mutation/workflows $GALAXY_HOME/workflows/

# install tools and workflows
ADD install-tools-workflows.sh $GALAXY_HOME/install-tools-workflows.sh
RUN chmod a+rwx $GALAXY_HOME/install-tools-workflows.sh
RUN $GALAXY_HOME/install-tools-workflows.sh

# Add/fix the barchart tool
# Enable the 'barchart_gnuplot' tool
RUN sed -i '114i<tool file="plotting/bar_chart.xml" />' /galaxy-central/config/tool_conf.xml.sample

# fix broken apt repo
#RUN grep 'yarnpkg' /etc/apt/sources.list /etc/apt/sources.list.d/*
#RUN grep 'research' /etc/apt/sources.list /etc/apt/sources.list.d/*
RUN rm /etc/apt/sources.list.d/htcondor.list

# Install gnuplot-py
RUN apt update
RUN apt install gnuplot libglu1 -y
RUN pip install numpy
RUN /tool_deps/_conda/bin/conda create -n __gnuplot-py@1.8 -c bioconda gnuplot-py -y
#RUN wget http://downloads.sourceforge.net/project/gnuplot-py/Gnuplot-py/1.8/gnuplot-py-1.8.tar.gz -O /home/galaxy/gnuplot-py.tar.gz
COPY hla-typing/gnuplot-py-1.8.tar.gz /home/galaxy/gnuplot-py-1.8.tar.gz
WORKDIR /home/galaxy/
RUN tar xvzf gnuplot-py-1.8.tar.gz
WORKDIR /home/galaxy/gnuplot-py-1.8/
RUN python setup.py install

WORKDIR /galaxy-central

# Add HLA blast db
ADD hla-typing/blast_database/hla /blast/hla
ADD hla-typing/blast_database/blastdb.loc /galaxy-central/tool-data/blastdb.loc

# install bcftools to save time on startup
RUN /tool_deps/_conda/bin/python /export/tool_deps/_conda/bin/conda create -y --override-channels --channel iuc --channel conda-forge --channel bioconda --channel defaults --name __bcftools@1.5 bcftools=1.5

# fix ireport
RUN sed -i 's|tool_deps/environment_settings/REPOSITORY_PATH/\(.*\);|shed_tools/toolshed.g2.bx.psu.edu/repos/\1/ireport/;|g' /export/tool_deps/environment_settings/REPOSITORY_PATH/saskia-hiltemann/ireport/*/env.sh

ENV GALAXY_CONFIG_BRAND "HLA-JAK2 [2020-06-04]"

VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]
