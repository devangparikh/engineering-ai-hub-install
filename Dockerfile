FROM registry.redhat.io/openshift4/ose-cli:latest
RUN dnf install python3.12 -y
CMD ["/bin/sh", "-c", "sleep infinity"]