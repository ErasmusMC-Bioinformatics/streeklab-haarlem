FROM bgruening/galaxy-stable:18.09

MAINTAINER Saskia Hiltemann (zazkia@gmail.com), David van Zessen (d.vanzessen@erasmusmc.nl)

ENV GALAXY_CONFIG_BRAND "HLA-JAK2 2020-02-02"

# Fix conda
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL "True"
ENV GALAXY_CONFIG_CONDA_AUTO_INIT "True"
ENV GALAXY_CONFIG_CONDA_ENSURE_CHANNELS "iuc,conda-forge,bioconda,defaults"

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

# Add/fix the barchart tool
# Enable the 'barchart_gnuplot' tool
RUN sed -i '114i<tool file="plotting/bar_chart.xml" />' /galaxy-central/config/tool_conf.xml.sample
# Install gnuplot-py
RUN apt update
RUN apt install gnuplot -y
RUN pip install numpy
RUN wget http://downloads.sourceforge.net/project/gnuplot-py/Gnuplot-py/1.8/gnuplot-py-1.8.tar.gz -O /home/galaxy/gnuplot-py.tar.gz
WORKDIR /home/galaxy/
RUN tar xzf gnuplot-py.tar.gz
WORKDIR /home/galaxy/gnuplot-py-1.8/
RUN python setup.py install

WORKDIR /galaxy-central



VOLUME ["/export/", "/data/", "/var/lib/docker"]

EXPOSE :80
EXPOSE :21
EXPOSE :8800

CMD ["/usr/bin/startup"]
