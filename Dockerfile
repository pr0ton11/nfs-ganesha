FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

# Package installation
RUN apt update && \
    apt install -y wget ca-certificates && \
    wget -O - https://download.nfs-ganesha.org/5/rsa.pub | tee /etc/apt/trusted.gpg.d/ganesha.asc && \
    echo "deb [arch=amd64] https://download.nfs-ganesha.org/5/LATEST/Debian/bookworm/amd64/apt bookworm main" > /etc/apt/sources.list.d/ganesha.list && \
    apt update && \
    apt install -y nfs-ganesha && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

EXPOSE 111 2049 20048 38465-38467

ENTRYPOINT ["/usr/bin/ganesha.nfsd", "-F", "-L", "/dev/stdout", "-f", "/etc/ganesha/ganesha.conf"]
