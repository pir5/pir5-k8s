FROM golang:latest AS build-stage

ARG appname

WORKDIR /tmp

RUN git clone https://github.com/pir5/$appname app
WORKDIR /tmp/app

RUN make build_binary BINARY=$appname SYSTEM="GOOS=linux GOARCH=amd64" BUILDOPTS=""

FROM debian:stable-slim

RUN apt update && apt install -y ca-certificates
COPY --from=build-stage /tmp/app/$appname /$appname

EXPOSE 8080 8080/TCP
