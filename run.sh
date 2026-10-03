#!/bin/sh

BASE_DIR="/mnt/data/jellyfin/youtube"
ARCHIVE_FILE="${BASE_DIR}/archive.txt"
KEEP=${MAX_KEEP:-5}
LANGS=${SUB_LANGS:-"ja"}
for ITEM in $CHANNELS; do
    ARTIST_NAME=$(echo "$ITEM" | cut -d':' -f1)
    HANDLE=$(echo "$ITEM" | cut -d':' -f2)
    
    CHANNEL_URL="https://www.youtube.com/${HANDLE}/videos"
    TARGET_DIR="${BASE_DIR}/${ARTIST_NAME}"

    echo "=========================================="
    echo "Processing: ${ARTIST_NAME} (${HANDLE})"
    echo "=========================================="

    mkdir -p "${TARGET_DIR}"
    yt-dlp \
        --ignore-errors \
        --download-archive "${ARCHIVE_FILE}" \
        --playlist-end 10 \
        --match-filter "duration > 60 & !is_live" \
        --format "bestvideo+bestaudio/best" \
        --merge-output-format mp4 \
        --write-subs \
        --write-auto-subs \
        --sub-langs "${LANGS}" \
        --sleep-subtitles 2 \
        --embed-subs \
        --write-thumbnail \
        --embed-thumbnail \
        --no-write-playlist-meta \
        --add-metadata \
        --output "${TARGET_DIR}/%(upload_date)s_%(title)s.%(ext)s" \
        "${CHANNEL_URL}"
    FILE_COUNT=$(ls -1 "${TARGET_DIR}"/*.mp4 2>/dev/null | wc -l)
    if [ "$FILE_COUNT" -gt "$KEEP" ]; then
        REMOVE_COUNT=$((FILE_COUNT - KEEP))
        ls -1 "${TARGET_DIR}"/*.mp4 | head -n "${REMOVE_COUNT}" | while read -r MP4_FILE; do
            BASENAME=$(echo "${MP4_FILE}" | sed 's/\.mp4$//')
            rm -f "${BASENAME}".*
        done
    fi
done

echo "Complete"
