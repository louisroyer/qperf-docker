FROM debian:bullseye-slim AS qperf-builder
RUN apt-get update -qq && DEBIAN_FRONTEND=non-interactive apt-get install -qqy --no-install-recommends --no-install-suggests \
    build-essential ca-certificates cmake git libev-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*
ARG QPERF_COMMIT
RUN : ${QPERF_COMMIT:? Missing build-arg QPERF_COMMIT.} && \
    git clone https://github.com/rbruenig/qperf --quiet --depth 1 && \
    git -C qperf checkout "${QPERF_COMMIT}" --quiet && \
    git -C qperf submodule update --init --quiet --depth 1 --recursive -j $(nproc) --checkout && \
    mkdir build-qperf
WORKDIR build-qperf
RUN cmake ../qperf && make

FROM debian:bullseye-slim AS qperf
RUN apt-get update -qq && DEBIAN_FRONTEND=non-interactive apt-get install -qqy --no-install-recommends --no-install-suggests \
    libev4 openssl \
    && rm -rf /var/lib/apt/lists/*
COPY --from=qperf-builder /build-qperf/qperf /usr/local/bin/qperf
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["-h"]
