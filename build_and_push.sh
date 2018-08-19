#!/bin/bash

IMAGE="mwelke/overpass-api-bicycle-parking-importer"
TAG_DATE="$(date +%Y%m%d)"

# Include download_data
bash download_data.sh

docker build -t ${IMAGE}:${TAG_DATE} .

# Additional tags
docker tag ${IMAGE}:${TAG_DATE} ${IMAGE}:latest

docker push ${IMAGE}:${TAG_DATE}
docker push ${IMAGE}:latest
