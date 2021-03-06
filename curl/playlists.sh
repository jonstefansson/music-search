#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search?search_type=count \
--data @"${basedir}/queries/playlists.json" \
  | jq '.aggregations.playlists.buckets'
