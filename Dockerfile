FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

# Package installation
RUN apt update && \
    apt install -y ca-certificates nfs-ganesha nfs-ganesha-rgw && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

EXPOSE 111 2049 20048 38465-38467

ENTRYPOINT ["/usr/bin/ganesha.nfsd", "-F", "-L", "/dev/stdout", "-f", "/etc/ganesha/ganesha.conf"]
