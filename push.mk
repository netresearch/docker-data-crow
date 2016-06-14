TAG           := 4.1-$(shell cat VERSION)
REGISTRY_NR   = couchi.nr:5001

.PHONY: push stable

push:
	docker tag ${DOCKER_REPO}:testing ${DOCKER_REPO}:${TAG}
	docker tag ${DOCKER_REPO}:testing ${DOCKER_REPO}:latest
	docker tag ${DOCKER_REPO}:testing ${REGISTRY_NR}/${DOCKER_REPO}:${TAG}
	docker tag ${DOCKER_REPO}:testing ${REGISTRY_NR}/${DOCKER_REPO}:latest
	docker push ${REGISTRY_NR}/${DOCKER_REPO}

stable:
	docker tag ${DOCKER_REPO}:testing ${DOCKER_REPO}:stable
	docker tag ${DOCKER_REPO}:testing ${REGISTRY_NR}/${DOCKER_REPO}:stable
	docker push ${REGISTRY_NR}/${DOCKER_REPO}
