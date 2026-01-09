#!/bin/sh

# Wait for Elasticsearch to be ready
until curl -s http://elasticsearch:9200 > /dev/null; do
  echo "Waiting for Elasticsearch..."
  sleep 2
done

echo "Elasticsearch is up. Running commands..."

# Create index and just log output
curl -X PUT http://elasticsearch:9200/earthquakes \
  -H 'Content-Type: application/json' \
  -d '{
    "mappings": {
      "properties": {
        "@timestamp": {"type": "date"},
        "coordinates": {"type": "geo_point"},
        "depth": {"type": "float"},
        "mag": {"type": "float"},
        "place": {"type": "text","fields":{"keyword":{"type":"keyword"}}},
        "sig": {"type": "short"},
        "type": {"type":"keyword"},
        "url": {"enabled": false}
      }
    }
  }'

echo ""
echo "------------------------"

# Create pipeline and just log output
curl -X PUT http://elasticsearch:9200/_ingest/pipeline/earthquake_data_pipeline \
  -H 'Content-Type: application/json' \
  -d '{
    "processors": [
      {
        "remove": {
          "field": ["updated","tz","detail","felt","cdi","mmi","alert","status","tsunami","net","code","ids","sources","types","nst","dmin","rms","gap","magType","title"],
          "ignore_missing": true
        }
      },
      { "date": { "field": "time", "formats": ["UNIX_MS"] } },
      { "remove": { "field": "time", "ignore_missing": true } },
      { "rename": { "field": "latitude", "target_field": "coordinates.lat", "ignore_missing": true } },
      { "rename": { "field": "longitude", "target_field": "coordinates.lon", "ignore_missing": true } }
    ]
  }'

echo ""
echo "------------------------"
echo "Commands finished!"
