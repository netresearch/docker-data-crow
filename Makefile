DOCKER_REPO   = netresearch/data-crow

.PHONY: all docker-image docker-image-nc build build_nc tests

all: docker-image

include push.mk
include version.mk

docker-image: build version_build
docker-image-nc: build_nc version_build

build:
	docker build -t ${DOCKER_REPO}:testing .

dev: create-dev-dockerfile build-dev

build_nc:
	docker build --no-cache=true -t ${DOCKER_REPO}:testing .

dev-nc: create-dev-dockerfile build-dev-nocache

create-dev-dockerfile:
	cp Dockerfile Dockerfile.dev
	perl -i~ -0777pe's{\n( *#[^\n]*\n)+}{\n}g;' Dockerfile.dev
	perl -i~ -0777pe's{ \\\n *&& }{\nRUN }g;' Dockerfile.dev
	perl -i~ -0777pe's{\nRUN cd }{\nWORKDIR }g;' Dockerfile.dev

build-dev:
	docker build -t ${DOCKER_REPO}:${TAG} -f Dockerfile.dev .
	rm Dockerfile.dev

build-dev-nocache:
	docker build --no-cache -t ${DOCKER_REPO}:${TAG} -f Dockerfile.dev .
	rm Dockerfile.dev

tests: tests_spec tests_phpunit

tests_spec:
	cd tests; rspec specs.rb

tests_phpunit:
	docker exec -ti -v ./tests:/tests ${DOCKER_REPO}:testing cd tests && vendor/bin/phpunit .
