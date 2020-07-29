# Docker images for [Zephyr RTOS](https://www.zephyrproject.org/)

Branches correspond to Zephyr releases.


## Building the image

Simple! Just call `make`.


## Using the image to build a Zephyr app

To build a Zephyr application, run:

```
docker run --rm -it brooksp/zephyr bash
```

then

```
cd /zephyrproject/zephyr
west build -p auto -b nrf52840_pca10056 samples/basic/blinky
```
