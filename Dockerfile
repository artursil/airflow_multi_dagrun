FROM python:3.6-slim


ARG DEBIAN_FRONTEND=noninteractive

ENV AIRFLOW_HOME=/home/airflow \
    SLUGIFY_USES_TEXT_UNIDECODE=yes \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_MESSAGES=en_US.UTF-8


RUN useradd -ms /bin/bash airflow

COPY requirements.txt /home/airflow


RUN set -ex && \
    buildDeps=' \
        python3-dev \
        build-essential \
        git \
    ' && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends $buildDeps

RUN pip install -r /home/airflow/requirements.txt
#    apt-get purge --auto-remove -y $buildDeps && \
#    apt-get autoremove -y --purge && \
#    apt-get clean && \
#    rm -rf && \
#        /var/lib/apt/lists/* \
#        /tmp/* \
#        /var/tmp/* \
#        /usr/share/man \
#        /usr/share/doc \
#        /usr/share/doc-base

EXPOSE 8080 8793

USER airflow

WORKDIR ${AIRFLOW_HOME}
