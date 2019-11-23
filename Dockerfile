FROM tensorflow/tensorflow:latest-gpu-py3

RUN apt-get update && apt-get install -y \
	openssl \
	net-tools \
	git \
	locales \
	sudo \
	dumb-init \
	vim \
	curl \
	wget \
  && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
# We cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LC_ALL=en_US.UTF-8 \
	SHELL=/bin/bash

RUN adduser --gecos '' --disabled-password tf-docker && \
	echo "tf-docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER tf-docker

WORKDIR /home/tf-docker

COPY ./code-server /home/tf-docker
EXPOSE 8888
ENTRYPOINT ["./code-server", "--port", "8888", "--host", "0.0.0.0", "--auth",  "password", "--user-data-dir", "/home/tf-docker/.local"]
