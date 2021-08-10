FROM webhippie/python:3.7
ENTRYPOINT [""]
ENV PY_COLORS=1
ENV ANSIBLE_FORCE_COLOR=true

# renovate: datasource=pypi depName=ansible
ENV ANSIBLE_VERSION=4.3.0

RUN apk update && \
  apk upgrade && \
  apk add rsync openssh-client libressl libffi libressl-dev libffi-dev build-base rust cargo && \
  pip3 install -U ansible==${ANSIBLE_VERSION} requests netaddr boto3 kubernetes PyMySQL && \
  apk del libressl-dev libffi-dev build-base rust cargo && \
  rm -rf /var/cache/apk/* && \
  ansible-galaxy collection install kubernetes.core community.mysql amazon.aws
