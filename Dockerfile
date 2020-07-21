FROM golang:alpine AS builder

ADD ./ /go/src/github.com/ph1ll/gitlab-recurring-issues

RUN set -ex && \
  cd /go/src/github.com/ph1ll/gitlab-recurring-issues && \       
  CGO_ENABLED=0 go build \
        -tags netgo \
        -v -a \
        -ldflags '-extldflags "-static"' && \
  mv ./gitlab-recurring-issues /usr/bin/gitlab-recurring-issues

FROM busybox

COPY --from=builder /usr/bin/gitlab-recurring-issues /usr/local/bin/gitlab-recurring-issues

ENTRYPOINT [ "gitlab-recurring-issues" ]