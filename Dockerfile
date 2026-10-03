FROM alpine:latest

RUN apk add --no-cache \
    yt-dlp \
    ffmpeg \
    nodejs \
    ca-certificates \
    tzdata \
    coreutils

ENV TZ=Asia/Tokyo

COPY run.sh /run.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /run.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
