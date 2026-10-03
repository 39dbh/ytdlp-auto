# compose.yml

```
services:
  kpop-downloader:
    image: ghcr.io/39dbh/ytdlp-auto:latest
    container_name: kpop
    restart: unless-stopped
    volumes:
      - /mnt/data/jellyfin/youtube:/mnt/data/jellyfin/youtube
    environment:
      - TZ=Asia/Tokyo
      - MAX_KEEP=5
      - SUB_LANGS=ja
      - CHANNELS=MEOVV:@MEOVV_OFFICIAL BABYMONSTER:@BABYMONSTER Hearts2Hearts:@hearts2hearts.official KiiiKiii:@KiiiKiii_starship
```

## yml解説

### volumes
downloadしたいdirectoryをしてい

### env

基本的な変数と、user idでの指定 + : を挟んでdirectory nameの指定
