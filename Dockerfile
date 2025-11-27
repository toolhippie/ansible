FROM ghcr.io/dockhippie/alpine:3.22@sha256:5b36d6c9994b3dbde7ff8e6140558b673d4ceb4d794c586073b934585c064a37
ENTRYPOINT [""]
ENV PY_COLORS=1
ENV ANSIBLE_FORCE_COLOR=true

# renovate: datasource=pypi depName=ansible
ENV ANSIBLE_VERSION=13.0.0

RUN apk update && \
  apk upgrade && \
  apk add gnupg git rsync openssh-client python3 python3-dev py3-pip py3-psycopg2 build-base openssl-dev libffi-dev cargo sshpass && \
  apk add --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community sops && \
  pip3 install --break-system-packages -U ansible==${ANSIBLE_VERSION} requests netaddr boto3 kubernetes PyMySQL && \
  apk del build-base openssl-dev libffi-dev cargo && \
  rm -rf /var/cache/apk/* /root/.cache && \
  ansible-galaxy collection install kubernetes.core community.mysql community.postgresql amazon.aws community.sops
