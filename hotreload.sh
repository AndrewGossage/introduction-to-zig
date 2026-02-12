#!/usr/bin/env bash
./run.sh

now=$(date +%s)
while true; do
    sleep 1
    for filename in $(fd | grep -E "(\.html|\.odin|\.js|\.sh|\.zig)"); do
        [ -f "$filename" ] || continue  # Skip if not a file
        mtime=$(stat -c %Y "$filename" 2>/dev/null || stat -f %m "$filename" 2>/dev/null)
        if [ "$mtime" -gt "$now" ]; then
            echo "$filename modified"
            ./run.sh
            now=$(date +%s)
        fi
    done
done
