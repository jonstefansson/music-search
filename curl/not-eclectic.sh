#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data @"${basedir}/queries/not-in-eclectic.json" \
| /usr/local/bin/jq -f "${basedir}/jq/hits.json" \
> "${basedir}/output/not-in-eclectic.json"