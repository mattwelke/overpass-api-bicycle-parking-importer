const fs = require('fs');

const nodes = JSON.parse(fs.readFileSync('data', 'utf8'));

const transformedNodes = nodes.map(n => ({
    _id: n.id,
    coordinates: [
        n.lon,
        n.lat
    ],
    tags: n.tags
}));

// Remove redundant tags
for (const n of transformedNodes) {
    if (n.tags.amenity) {
        delete n.tags.amenity;
    }
}

const outFile = fs.openSync('data_transformed.json', 'w');

fs.writeSync(outFile, JSON.stringify(transformedNodes));

console.info('Finished Node transform step.');
