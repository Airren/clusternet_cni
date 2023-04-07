FROM ubuntu:jammy
WORKDIR /
RUN echo 'Acquire::http::Proxy "http://child-prc.intel.com:913"; \
    Acquire::https::Proxy "http://child-prc.intel.com:913";' > etc/apt/apt.conf.d/proxy.conf \
    && apt-get update && apt install iproute2 iptables  -y
COPY ./cni /

ENTRYPOINT "/cni"