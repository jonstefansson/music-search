#!/usr/bin/env bash

curl \
-v \
-X post \
--header "Content-Type: application/json; charset=UTF-8" \
--header "Accept: application/json" \
--data-binary @queries/playlist-search.json \
--url http://localhost:9200/music/track/_search \
| jq '.'
