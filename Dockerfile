FROM ubuntu:20.04
LABEL maintainer="Brooks Prumo <brooks@prumo.org>"

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	apt-utils \
	ca-certificates \
	ccache \
	cmake \
	device-tree-compiler \
	dfu-util \
	file \
	g++-multilib \
	gcc \
	gcc-multilib \
	git \
	gnupg \
	gperf \
	libsdl2-dev \
	make \
	ninja-build \
	python3 \
	python3-dev \
	python3-pip \
	python3-setuptools \
	python3-tk \
	python3-wheel \
	software-properties-common \
	wget \
	xz-utils

RUN pip3 install -U west
ENV PATH=/usr/local/bin:$PATH
RUN west init /zephyrproject \
	&& cd /zephyrproject \
	&& west update \
	&& west zephyr-export \
	&& pip3 install -r zephyr/scripts/requirements.txt
RUN wget --quiet https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.11.4/zephyr-sdk-0.11.4-setup.run
RUN chmod +x zephyr-sdk-0.11.4-setup.run \
	&& /zephyr-sdk-0.11.4-setup.run --quiet -- -d /opt/zephyr-sdk-0.11.4 \
	&& rm -f /zephyr-sdk-0.11.4-setup.run

WORKDIR /zephyrproject
