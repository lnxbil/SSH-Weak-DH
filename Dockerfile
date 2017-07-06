FROM ubuntu:14.04

RUN \
    apt-get update -qq; \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq \
        coreutils build-essential automake patch libssl-dev python bash wget tar; \
    apt-get build-dep openssh; \
    apt-get clean

RUN mkdir -p /opt/sshweakdh/configs

COPY [ "openssh.patch", "ssh-weak-dh*", "setup.sh", "/opt/sshweakdh/" ]
COPY [ "configs",  "/opt/sshweakdh/configs" ]

WORKDIR /opt/sshweakdh
RUN /opt/sshweakdh/setup.sh; rm -f openssh-7.3p1.tar.gz

ENTRYPOINT [ "/opt/sshweakdh/ssh-weak-dh-test.sh" ]
