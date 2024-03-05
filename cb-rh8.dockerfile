FROM rockylinux:8-minimal

RUN sed -i.bak -e's/enabled=0/enabled=1/g' /etc/yum.repos.d/Rocky-PowerTools.repo
RUN microdnf install yum
RUN yum install -y autoconf \
    binutils \
    bison \
    diffstat \
    elfutils-libelf-devel \
    flex \
    gcc \
    gcc-c++ \
    glibc-devel \
    libtool \
    make \
    patchutils \
    rpm-build \
    libmount-devel \
    libyaml-devel \
    python36-devel \
    kmod \
    kernel \
    kernel-devel \
    kernel-rpm-macros \
    kernel-abi-whitelists \
    libnl3-devel \
    json-c-devel
