#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data @"${basedir}/queries/album-jazz.json" \
| jq '.' \
> "${basedir}/output/album-jazz.json"
