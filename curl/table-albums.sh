#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

category='classical'
category='jazz'

echo '| Album                   | Artist               |' > "${basedir}/output/${category}.txt"

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data @"${basedir}/queries/album-${category}.json" \
| jq -r '.facets["album-facets"].terms[] | .term' \
| while read -r title; do
curl \
-s \
--get \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data-urlencode "q=album:'$(echo $title | sed 's/:/\\:/' | sed 's/\// /g' | sed 's/[][]//g' | sed 's/\!/\\!/g')'" \
| jq -r '.hits.hits[0]._source | "| \(.album) | \(.artist) |"'
done \
>> "${basedir}/output/${category}.txt"
