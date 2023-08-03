# yt-dlp-container

[![Publish image](https://github.com/gntouts/yt-dlp-container/actions/workflows/push.yml/badge.svg)](https://github.com/gntouts/yt-dlp-container/actions/workflows/push.yml)

Automatically updated [Docker container](https://hub.docker.com/repository/docker/gntouts/yt-dlp) with [yt-dlp](https://github.com/yt-dlp/yt-dlp/)

Support for Linux and architectures:

- amd64
- arm64

## Usage

```bash
docker pull gntouts/yt-dlp:latest
docker run --rm -ti -v $(pwd):/workspace gntouts/yt-dlp https://www.youtube.com/watch?v=2xx_2XNxxfA
```

You can also add it as an alias:

```bash
alias youtube-dl='docker run --rm -ti -v $(pwd):/workspace gntouts/yt-dlp'
```

And then use it, as you would with a normal youtube-dl installation:

```bash
youtube-dl https://www.youtube.com/watch?v=2xx_2XNxxfA
```