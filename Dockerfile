FROM alpine:3

ENV VERSION 0.9.1

RUN apk add --no-cache git && \
    wget https://github.com/git-chglog/git-chglog/releases/download/$VERSION/git-chglog_linux_amd64 -O /usr/local/bin/git-chglog && \
    chmod +x /usr/local/bin/git-chglog

COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
