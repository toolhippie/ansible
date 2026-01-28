FROM ghcr.io/dockhippie/alpine:3.23@sha256:a674aadc1cccd2f424673c7596eff46336210016a50c8082849071f78bb15105
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
