#!/usr/bin/env bash

curl \
-s \
--request DELETE \
--header "Accept: application/json" \
--url http://localhost:9200/music \
| jq '.'
