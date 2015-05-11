#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data @"${basedir}/queries/playlists.json" \
| jq -r '.facets["playlist-facets"].terms[] | "\(.term)	\(.count)"' \
> "${basedir}/output/playlists.txt"
