ARG OS=alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

# Download and extract Dalamud
FROM alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c AS builder
ARG DALAMUD_BRANCH=latest
WORKDIR /build

RUN apk add --no-cache wget unzip \
    && if [ "$DALAMUD_BRANCH" = "latest" ]; then export DALAMUD_BRANCH="latest.zip"; else export DALAMUD_BRANCH="${DALAMUD_BRANCH}/latest.zip"; fi \
    && wget -O dalamud.zip https://goatcorp.github.io/dalamud-distrib/${DALAMUD_BRANCH} \
    && unzip dalamud.zip -d dalamud

# Build the final image
FROM ${OS}
ENV DALAMUD_HOME=/usr/lib/dalamud
COPY --from=builder /build/dalamud/ ${DALAMUD_HOME}/