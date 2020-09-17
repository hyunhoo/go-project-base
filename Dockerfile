FROM golang:1.14-alpine AS go-builder

COPY . /builder

WORKDIR /builder

ENV PACKAGES make git libc-dev bash gcc linux-headers eudev-dev
RUN apk add --no-cache $PACKAGES

RUN make clean
RUN make build-linux -B

FROM alpine

COPY --from=go-builder /builder/build/project /service/project

WORKDIR /service

EXPOSE 8080

CMD ["./project"]
