#!/bin/bash

# Include download_data
bash download_data.sh

docker build -t mwelke/overpass-api-bicycle-parking-importer:$(date +%Y%m%d) .

docker push mwelke/overpass-api-bicycle-parking-importer:$(date +%Y%m%d)
