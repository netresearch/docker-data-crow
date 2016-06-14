TAG           := 4.1-$(shell cat VERSION)
REGISTRY_NR   = couchi.nr:5001

.PHONY: push stable

push:
	docker tag -f ${DOCKER_REPO}:testing ${DOCKER_REPO}:${TAG}
	docker tag -f ${DOCKER_REPO}:${TAG} ${REGISTRY_NR}/${DOCKER_REPO}:${TAG}
	docker push ${REGISTRY_NR}/${DOCKER_REPO}:${TAG}
	docker tag -f ${DOCKER_REPO}:${TAG} ${REGISTRY_NR}/${DOCKER_REPO}:latest
	docker push ${REGISTRY_NR}/${DOCKER_REPO}:latest

stable:
	docker tag -f ${DOCKER_REPO}:testing ${DOCKER_REPO}:${TAG}
	docker tag -f ${DOCKER_REPO}:${TAG} ${REGISTRY_NR}/${DOCKER_REPO}:stable
	docker push ${REGISTRY_NR}/${DOCKER_REPO}:stable
