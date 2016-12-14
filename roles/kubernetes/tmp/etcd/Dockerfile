FROM ubuntu:14.04
MAINTAINER Liu Zhenwei <zwliu@thoughtworks.com>

RUN mkdir /data
COPY etcd /usr/bin/

COPY etcdctl /usr/bin/

VOLUME ["/data"]
EXPOSE 4001 7001 2379 2380

ENTRYPOINT ["/usr/bin/etcd"]

CMD ["--data-dir /data"]
