FROM ubuntu:14.04
MAINTAINER Liu Zhenwei <zwliu@thoughtworks.com>

RUN mkdir -p /opt/k8s/cert/

COPY kube-controller-manager /usr/bin/


ENTRYPOINT ["/usr/bin/kube-controller-manager"]

CMD ["--help"]
