# Download latest OSM data, map it to just the elements array, replacing "id: " with "_id: "
echo "  Downloading OSM data. This can take a few minutes."

curl 'https://overpass-api.de/api/interpreter?data=\[out:json\]\[timeout:180\];(node\[amenity=bicycle_parking\];);out;' \
  | jq '.elements' > data
