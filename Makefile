.PHONY: build run

.SUFFIXES:

OPEN = $(shell which xdg-open || which open)
PORT ?= 9000

install:
	npm install -g grunt-cli

build:
	grunt build
	docker build --rm -t dockerui .

build-release:
	grunt release
	docker build --rm -t dockerui .

test:
	grunt

run:
	-docker stop dockerui
	-docker rm dockerui
	docker run -d -p $(PORT):9000 -v /var/run/docker.sock:/docker.sock --name dockerui dockerui -e /docker.sock 

open:
	$(OPEN) localhost:$(PORT)


