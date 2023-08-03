image:
	docker buildx build --platform linux/arm64,linux/amd64 --push -t $$USER/yt-dlp:latest