FROM ubuntu:14.04
MAINTAINER adolphlwq kenan3015@gmail.com

ENV AIRFLOW_VERSION 1.7.1.3

RUN apt-get update && \
    set -ex && \
    buildDeps=' \
    python-dev \
    libkrb5-dev \
    libsasl2-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    build-essential \
    libatlas-dev \
    libpq-dev \ 
    libblas-dev \
    liblapack-dev' && \
    apt-get install -y --no-install-recommends $buildDeps \
    supervisor vim git ca-certificates python-pip && \
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
RUN pip install airflow==$AIRFLOW_VERSION && \
    apt-get remove --purge -y $buildDeps && \
    apt-get clean && \
    rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/* \
      /usr/share/man \
      /usr/share/doc \
      /usr/share/doc-base

ENV AIRFLOW_HOME ~/airflow
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
