# overpass-api-bicycle-parking-importer

Serves as a Docker image containing a program able to perform a **mongoimport** to a MongoDB database with the latest data available from OpenStreetMap, where nodes are marked "amenity=bicycle_parking". Used in a proprietary project, but available for open source needs.

## Build

**Note: You must be logged into the "mwelke" Docker Hub account to push the image.** The build process is not meant to be performed by consumers of this image. The latest tagged images are available for free, public use in the [mwelke/overpass-api-bicycle-parking-importer](https://hub.docker.com/r/mwelke/overpass-api-bicycle-parking-importer/) public Docker repository.

1. Ensure `curl`, `jq`, and `Docker` are installed.
1. Run `build_and_push.sh`.
1. An image will be created with the tag `mwelke/overpass-api-bicycle-parking-importer:YYYYMMDD`.

## Use

To use the image, build a Docker network with a MongoDB database as one of the services, with a tool like `docker-compose` or Kubernetes. Provide the host of the MongoDB database to the importer. See the example `docker-compose.yml` file for reference.

When the containers start up, the importer will connect to the MongoDB specified and perform the import. This status can be seen in the Docker logs.

You can also use the command `.download_data.sh && ./program.sh` to download and import the data independently of Docker. Make sure the environment variable `MONGODB_HOST` is set and run the scripts with a MongoDB database accessible at the value of that environment variable. The import will proceed.

## Data Layout

In the MongoDB database, the data will exist in the `local` database in a collection called `nodes`.

Each document will have a BSON structure like this:

```bson
{
    "_id" : NumberLong(3013604535),
    "location" : {
        "type" : "Point",
        "coordinates" : [ 
            -79.4165008, 
            43.7821196
        ]
    },
    "tags" : {
        "capacity" : "3",
        "colour" : "gray",
        "note" : "ring and post"
    }
}
```

With a `2dsphere` index added to the `location` field, it can be queried with a geospatial query like `$nearSphere` like this:

```javascript
// MongoDB shell

db.getCollection('nodes').find({
    location: { $nearSphere: {
        $geometry: {
            type: "Point",
            coordinates: [
                -79.4397698,
                43.755323
            ]
        },
        $maxDistance: 10000
    } }
});
```
