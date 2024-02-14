# Figure out what container backend to use
BACKEND=
DOCKER=$(shell type -p docker)
PODMAN=$(shell type -p podman)

ifdef PODMAN
BACKEND=${PODMAN}
else
ifdef DOCKER
BACKEND=${DOCKER}
endif
endif

ifndef BACKEND
$(error Please set BACKEND or install either podman or docker)
endif

# Make sure the sources are available
LUSTRE_SOURCES ?= lustre-sources
__LUSTRE_SOURCES_ABP = $(shell realpath ${LUSTRE_SOURCES})

# Look for the kernel headers and error out if missing
KERNEL_HEADERS ?= /usr/src/kernels/$(shell uname -r)

ifeq ("$(wildcard ${KERNEL_HEADERS})", "")
$(warning Cannot find kernel headers: ${KERNEL_HEADERS})
$(warning Please set KERNEL_HEADERS or install your distribution's kernel header package)
endif

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} \
		| awk 'BEGIN {FS = ":.*?##"}; {printf "\033[36m- %-20s\033[0m %s\n", $$1, $$2}' \
		| sort

install: ## Prepare the container backend by installing the image
	$(info Using container backend: ${BACKEND})
	${BACKEND} load < rhel8.tar.gz

fetch-rpms:
	mkdir -p RPMS
	cd RPMS && yumdownloader kernel-core kernel-devel

build: ${KERNEL_HEADERS} fetch-rpms ## Build the client RPMs
	${BACKEND} run -it --rm                                                    \
		--security-opt label=disable                                           \
		-v ${PWD}/RPMS:/host/rpms                                              \
		-v ${__LUSTRE_SOURCES_ABP}:/host/lustre                                \
		-v ${KERNEL_HEADERS}:/host/kernel                                      \
		client-builder:rhel8                                                   \
		bash -c "rpm -i --force /host/rpms/*                                   \
			&& cd /host/lustre                                                 \
			&& ./configure --disable-tests --disable-server --with-linux=/host/kernel \
			&& make -j rpms"
