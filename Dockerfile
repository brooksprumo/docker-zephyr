FROM ubuntu:18.04
LABEL maintainer="Brooks Prumo <brooks@prumo.org>"

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	apt-utils \
	ca-certificates \
	ccache \
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

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
	&& apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends cmake

RUN pip3 install -U west
ENV PATH=/usr/local/bin:$PATH
RUN west init /zephyrproject \
	&& cd /zephyrproject \
	&& west update \
	&& west zephyr-export \
	&& pip3 install -r zephyr/scripts/requirements.txt
RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.11.3/zephyr-sdk-0.11.3-setup.run \
	&& chmod +x zephyr-sdk-0.11.3-setup.run \
	&& /zephyr-sdk-0.11.3-setup.run -- -d /zephyr-sdk-0.11.3 \
	&& rm -f /zephyr-sdk-0.11.3-setup.run
ENV PATH=/zephyr-sdk-0.11.3/sysroots/x86_64-pokysdk-linux/usr/bin:$PATH

WORKDIR /zephyrproject
