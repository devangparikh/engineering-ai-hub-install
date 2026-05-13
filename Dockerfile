FROM registry.redhat.io/openshift4/ose-cli:latest
RUN dnf upgrade python3 -y
CMD ["/bin/sh", "-c", "sleep infinity"]