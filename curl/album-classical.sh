#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

# | jq -r '.facets["album-facets"].terms[] | .term' \

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data @"${basedir}/queries/album-classical.json" \
| jq '.' \
> "${basedir}/output/album-classical.json"
