DOCKER_REGISTERY := satmishra/tc-jammy
DOCKER_IMAGE_NAME := docker-ubuntu-22-04
DOCKER_IMAGE := $(DOCKER_REGISTERY)/$(DOCKER_IMAGE_NAME)

# Build and publish the docker image
.PHONY: all
all: build push-image

# Build the image
.PHONY: build
build:
#	docker build --rm --build-arg UBUNTU_URL=$(UBUNTU_URL) -t $(DOCKER_IMAGE):dev .
	docker build --rm  -t $(DOCKER_IMAGE):dev .

# Publish the image
.PHONY: push-image
push-image: build
	docker login
	docker tag $(DOCKER_IMAGE):dev satmishra/tc-jammy:$(DOCKER_IMAGE_NAME)
	docker push satmishra/tc-jammy:$(DOCKER_IMAGE_NAME)

# Clean the image
.PHONY: clean
clean:
# View all docker images
	docker image ls
# Clean the specific docker image
	docker image rmi -f $(DOCKER_IMAGE):dev
# Clean the all docker images
#	docker rmi -f $(docker images -aq)
# View all docker images after clean
	docker image ls

# Test the image
.PHONY: test
test: build
	docker run -it --rm --entrypoint bash satmishra/tc-jammy:$(DOCKER_IMAGE_NAME)