FROM ghcr.io/dockhippie/alpine:3.23@sha256:f857559a03da3017be1663750116349e56d315cf0f86e64f508aa0613a9ef313
ENTRYPOINT [""]
ENV PY_COLORS=1
ENV ANSIBLE_FORCE_COLOR=true

# renovate: datasource=pypi depName=ansible
ENV ANSIBLE_VERSION=13.2.0

RUN apk update && \
  apk upgrade && \
  apk add gnupg git rsync openssh-client python3 python3-dev py3-pip py3-psycopg2 build-base openssl-dev libffi-dev cargo sshpass && \
  apk add --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community sops && \
  pip3 install --break-system-packages -U ansible==${ANSIBLE_VERSION} requests netaddr boto3 kubernetes PyMySQL && \
  apk del build-base openssl-dev libffi-dev cargo && \
  rm -rf /var/cache/apk/* /root/.cache && \
  ansible-galaxy collection install kubernetes.core community.mysql community.postgresql amazon.aws community.sops
