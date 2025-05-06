FROM scratch

ARG TARGETOS
ARG TARGETARCH
ARG PREFIX=cucumber-json-formatter

COPY --chmod=755 --from=binaries ${PREFIX}-${TARGETOS}-${TARGETARCH} /cucumber-json-formatter

ENTRYPOINT ["/cucumber-json-formatter"]
