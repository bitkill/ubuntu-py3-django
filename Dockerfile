FROM ubuntu:16.04
LABEL maintainer="Rui Fernandes (@bitkill)"

ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-setuptools \
    python3 python3-pip python3-dev python3-tk python3-mysqldb fontconfig wget build-essential gcc libffi-dev libssl-dev \
    libfontconfig1 libfreetype6 libjpeg-turbo8 libx11-6 libxext6 libssl-dev \
    libxrender1 xfonts-base xfonts-75dpi curl && \
    wget -q https://downloads.wkhtmltopdf.org/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    rm /usr/local/bin/wkhtmltoimage && \
    apt-get autoclean

RUN ln -s /usr/bin/pip3 /usr/bin/pip
RUN pip install --upgrade pip
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir /code
WORKDIR /code
RUN pip install wheel && pip install uwsgi && pip install cryptography

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000

ENV PUID ${PUID}
ENV PGID ${PGID}

RUN groupadd -g ${PGID} pyuser && \
    useradd -u ${PUID} -g pyuser -m pyuser

ENV DISPLAY :0

EXPOSE 80