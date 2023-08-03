FROM alpine:latest as dl

ARG version
ENV version $version

ARG TARGETARCH
RUN apk add --no-cache curl
RUN version=$(curl -L -s -o /dev/null -w '%{url_effective}' "https://github.com/yt-dlp/yt-dlp/releases/latest" | awk -F'/' '{print $NF}') &&\
    curl -L -o youtube-dl https://github.com/yt-dlp/yt-dlp/releases/download/$YT_DL/yt-dlp_linux_${TARGETARCH}

RUN version=$(curl -L -s -o /dev/null -w '%{url_effective}' "https://github.com/yt-dlp/yt-dlp/releases/latest" | awk -F'/' '{print $NF}') && \
    case "$TARGETARCH" in \
        amd64) curl -L -o youtube-dl https://github.com/yt-dlp/yt-dlp/releases/download/$version/yt-dlp_linux ;; \
        arm64) curl -L -o youtube-dl https://github.com/yt-dlp/yt-dlp/releases/download/$version/yt-dlp_linux_aarch64 ;; \
        *) echo "Invalid platform"; exit 1 ;; \
    esac

FROM alpine:latest

COPY --from=dl /youtube-dl /usr/local/bin/youtube-dl
RUN chmod +x /usr/local/bin/youtube-dl