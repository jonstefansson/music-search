#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

query=${1:?'query is required'}

query=$(echo $query | sed 's/:/\\\\:/' | sed 's/\// /g' | sed -e 's/[][]//g' | sed 's/\!/\\!/g')

json='{
	"query" : {
		"query_string" : {
			"query" : "'\'${query}\''"
		}
	}
}'

curl \
-s \
--request POST \
--header "Content-Type: application/json" \
--header "Accept: application/json" \
--url http://localhost:9200/music/track/_search \
--data "$json" \
| jq -M '.'
