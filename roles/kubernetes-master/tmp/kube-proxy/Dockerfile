FROM ubuntu:14.04
MAINTAINER Liu Zhenwei <zwliu@thoughtworks.com>

RUN mkdir -p /opt/k8s/cert/

COPY kube-proxy /usr/bin/

RUN apt-get update && apt-get install iptables -y

ENTRYPOINT ["/usr/bin/kube-proxy"]

CMD ["--help"]
