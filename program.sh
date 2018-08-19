#!/bin/bash

echo "Beginning mongorestore..."

# Perform the import.
#   Get host from environment variable (controlling which MongoDB it performs the import to)
#   Use "upsert" so that this image can be used to update data in an existing MongoDB
mongoimport --host=${MONGODB_HOST} --db=local --collection=nodes --jsonArray --upsert data.json

echo "Finished mongorestore!"
