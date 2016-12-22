FROM ubuntu:14.04
MAINTAINER adolphlwq kenan3015@gmail.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends supervisor vim git ca-certificates python-pip python-dev && \
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh && \
    apt-get clean
RUN pip install airflow[all]
ENV AIRFLOW_HOME ~/airflow
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
