FROM alpine:3

RUN wget https://github.com/git-chglog/git-chglog/releases/download/${version}/git-chglog_${os}_${arch} -O /git-chglog & \
    chmod +x /git-chglog & \
    : "Create /entrypoint.sh" && { \
    echo '#!/bin/sh -l'; \
    echo 'git clone --quiet https://github.com/$repository &> /dev/null'; \
    echo 'changelog=$(/git-chglog $tag)'; \
    echo 'echo "::set-output name=changelog::$changelog"'; \
    } | tee /entrypoint.sh && \
    chmod +x /entrypoint.sh

COPY LICENSE README.md /

ENTRYPOINT ["/entrypoint.sh"]
