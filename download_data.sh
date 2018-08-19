# Download latest OSM data, map it to just the elements array, replacing "id: " with "_id: "
echo "Downloading OSM data. Please wait. This can take up to 3 minutes..."

curl 'https://lz4.overpass-api.de/api/interpreter?data=\[out:json\]\[timeout:180\];(node\[amenity=bicycle_parking\];);out;' \
  | jq '.elements' > data

# Use Node script to transform JSON data
node transform_data.js

# Delete old data
rm data
