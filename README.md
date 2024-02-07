# Lustre client builder

This repository contains images and recipes to build the Lustre client without
installing all the packages, using containers.

Building a Lustre client is dependent on the host kernel, which is accessible
from a container. The images in this repository contain a minimal EL
distribution with all the necessary development RPMs. All that is needed from
the host is the kernel headers package, whose contents will be bound to the
container when running it.

## Usage

Unpack the lustre sources to use in `lustre-sources`.

Available `make` commands are:
```
- build               Build the client RPMs
- install             Prepare the container backend by installing the image
```

The following environment variables can configure the execution:
- `LUSTRE_SOURCES`: The location of the lustre sources. Default is
  `lustre-sources`.
- `KERNEL_HEADERS`: The location of the kernel headers if not default.
