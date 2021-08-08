FROM webhippie/python:latest

ENTRYPOINT [""]

ENV PY_COLORS=1

RUN apk update && \
  apk upgrade && \
  apk add rsync openssh-client libressl libressl-dev libffi-dev build-base rust cargo && \
  pip3 install -U pip ansible requests netaddr kubernetes PyMySQL boto3 && \
  apk del libressl-dev libffi-dev build-base rust cargo && \
  rm -rf /var/cache/apk/* && \
  ansible-galaxy collection install kubernetes.core community.mysql amazon.aws
