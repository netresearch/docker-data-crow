MAJOR := $(shell awk -F. '{print $$1}' VERSION)
MAJOR := $(shell if [ -z "${MAJOR}" ]; then echo 0; else echo ${MAJOR}; fi;)
MINOR := $(shell awk -F. '{print $$2}' VERSION)
MINOR := $(shell if [ -z "${MINOR}" ]; then echo 0; else echo ${MINOR}; fi;)
FIX := $(shell awk -F. '{print $$3}' VERSION)
FIX := $(shell if [ -z "${FIX}" ]; then echo 0; else echo ${FIX}; fi;)
BUILD := $(shell awk -F. '{print $$4}' VERSION)
BUILD := $(shell if [ -z "${BUILD}" ]; then echo 0; else echo ${BUILD}; fi;)

.PHONY: major minor fix

version_major: _version_major echo_version commit_version

_version_major:
	echo $$(( ${MAJOR} + 1 )).0.0.${BUILD} > VERSION

version_minor: _version_minor echo_version commit_version

_version_minor:
	echo ${MAJOR}.$$(( ${MINOR} + 1 )).0.${BUILD} > VERSION

version_fix: _version_fix echo_version commit_version

_version_fix:
	echo ${MAJOR}.${MINOR}.$$(( ${FIX} + 1 )).${BUILD} > VERSION

version_build: _version_build echo_version

_version_build:
	echo ${MAJOR}.${MINOR}.${FIX}.$$(( ${BUILD} + 1 )) > VERSION

echo_version:
	echo New version: `cat VERSION`

commit_version:
	git add VERSION
	git commit -nm"Version `cat VERSION`"
	git tag v`cat VERSION`
	docker tag -f ${DOCKER_REPO}:testing ${DOCKER_REPO}:`cat VERSION`
