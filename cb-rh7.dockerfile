FROM centos:7

#RUN sed -i.bak -e's/enabled=0/enabled=1/g' /etc/yum.repos.d/*
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
    kernel-devel \
    kernel-rpm-macros \
    libnl3-devel \
    json-c-devel

# Let the user use his own copy instead of preloading the sources
# COPY ./lustre-release /lustre
# WORKDIR /lustre
# RUN rm -fr .git             # Save 200M
# RUN bash autogen.sh
