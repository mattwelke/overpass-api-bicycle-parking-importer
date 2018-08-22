#!/bin/bash

PARAM_SKIP_DL=$1

if [ "${PARAM_SKIP_DL}" = "-s" ]; then
    echo "  Skipping download, using previous download file."

    if [ ! -f ./data ]; then
        echo "  Previous download file not present. Cannot continue."
        exit 1
    fi

    if ! jq . ./data > /dev/null 2>&1 ; then
        echo "  Previous download file present but not valid JSON. Cannot continue."
        exit 1
    fi
else
    echo "  Downloading fresh data from OpenStreetMap Overpass API."
    bash download_data.sh
fi

# Whether we're using the old data or new downloaded data, transform it.
echo "  Transforming data with Node script."
node transform_data.js

IMAGE="mwelke/overpass-api-bicycle-parking-importer"
TAG_DATE="$(date +%Y%m%d)"

echo "  Docker image tags will be:"
echo "    ${IMAGE}:${TAG_DATE}"
echo "    ${IMAGE}:latest"
docker build -t ${IMAGE}:${TAG_DATE} .
echo "  Docker image built."

# Additional tags
docker tag ${IMAGE}:${TAG_DATE} ${IMAGE}:latest

docker push ${IMAGE}:${TAG_DATE}
docker push ${IMAGE}:latest
