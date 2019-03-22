.PHONY: all
all: build

build:
	bin/docker/build

deploy:
	bin/docker/deploy

run:
	bin/docker/run

setup:
	bin/setup
