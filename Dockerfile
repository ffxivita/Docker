ARG OS=alpine

# Download and extract
FROM alpine:3.18 AS builder
ARG DALAMUD_BRANCH=latest
WORKDIR /build

RUN apk add --no-cache wget unzip \
    && if [ "$DALAMUD_BRANCH" = "latest"]; then export DALAMUD_BRANCH="latest.zip"; else export DALAMUD_BRANCH="${DALAMUD_BRANCH}/latest.zip"; fi \
    && wget -O dalamud.zip https://goatcorp.github.io/dalamud-distrib/${DALAMUD_BRANCH} \
    && unzip dalamud.zip -d dalamud

# Build the image
FROM ${OS}
ENV DALAMUD_HOME=/usr/lib/dalamud
COPY --from=builder /build/dalamud/ ${DALAMUD_HOME}/