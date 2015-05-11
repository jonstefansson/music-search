#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}
title=${1:-''}

title='Bach: Keyboard Concertos, Vol. 2'
title=$(echo $title | sed 's/:/\\\\:/' | sed 's/\// /g' | sed -e 's/[][]//g' | sed 's/\!/\\!/g')

# | jq -r '.hits.hits[0]._source | "| \(.album) | \(.artist) |"'

query='{
	"query" : {
		"query_string" : {
			"query" : "album.facet:'\'${title}\''"
		}
	}
}'

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data "$query" \
| jq -M '.'

# --data-urlencode "q=album.facet:'${title}'" \
# | jq '.'
