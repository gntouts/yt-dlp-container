FROM debian:latest as dl

ARG TARGETARCH
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install curl -y

RUN version=$(curl -L -s -o /dev/null -w '%{url_effective}' "https://github.com/yt-dlp/yt-dlp/releases/latest" | awk -F'/' '{print $NF}') &&\
    curl -L -o youtube-dl https://github.com/yt-dlp/yt-dlp/releases/download/$YT_DL/yt-dlp_linux_${TARGETARCH}

RUN version=$(curl -L -s -o /dev/null -w '%{url_effective}' "https://github.com/yt-dlp/yt-dlp/releases/latest" | awk -F'/' '{print $NF}') && \
    case "$TARGETARCH" in \
        amd64) curl -L -o youtube-dl https://github.com/yt-dlp/yt-dlp/releases/download/$version/yt-dlp_linux ;; \
        arm64) curl -L -o youtube-dl https://github.com/yt-dlp/yt-dlp/releases/download/$version/yt-dlp_linux_aarch64 ;; \
        *) echo "Invalid platform"; exit 1 ;; \
    esac

FROM debian:latest
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --purge ffmpeg -y
COPY --from=dl /youtube-dl /usr/local/bin/youtube-dl
RUN chmod +x /usr/local/bin/youtube-dl
WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/youtube-dl"]