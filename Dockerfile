FROM registry.svc.ci.openshift.org/ocp/builder:rhel-8-golang-openshift-4.6 AS builder
WORKDIR /go/src/github.com/openshift/cluster-api-provider-baremetal
COPY . .
RUN go build --mod=vendor -o machine-controller-manager ./cmd/manager

FROM registry.svc.ci.openshift.org/ocp/4.6:base
#RUN INSTALL_PKGS=" \
#      libvirt-libs openssh-clients genisoimage \
#      " && \
#    yum install -y $INSTALL_PKGS && \
#    rpm -V $INSTALL_PKGS && \
#    yum clean all
COPY --from=builder /go/src/github.com/openshift/cluster-api-provider-baremetal/machine-controller-manager /
