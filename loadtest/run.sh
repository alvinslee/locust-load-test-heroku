#!/bin/bash

locust -f $1 --headless -u 200 -r 10 --host=$TARGET_HOST --csv="$2_$(date +%F_%T)" --run-time 1m -t 2s --stop-timeout 60

for filename in *.csv; do
    [ -e "$filename" ] || continue
    azcopy copy "$filename" "https://alvinslee.blob.core.windows.net/devspotlight-load-test/$filename$SAS_TOKEN"
done

exit 0