FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

# Package installation
RUN apt update && \
    apt install -y ca-certificates nfs-ganesha nfs-ganesha-ceph nfs-ganesha-gluster nfs-ganesha-gpfs nfs-ganesha-mem nfs-ganesha-mount-9p nfs-ganesha-nullfs nfs-ganesha-proxy-v4 nfs-ganesha-rados-grace nfs-ganesha-vfs nfs-ganesha-rgw && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

EXPOSE 111 2049 20048 38465-38467

ENTRYPOINT ["/usr/bin/ganesha.nfsd", "-F", "-L", "/dev/stdout", "-f", "/etc/ganesha/ganesha.conf"]
