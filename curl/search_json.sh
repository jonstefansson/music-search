#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

# http://lucene.apache.org/core/3_0_3/queryparsersyntax.html
# https://www.elastic.co/guide/en/elasticsearch/reference/current/search-uri-request.html
# Examples:
# album:bach
# artist:salonen
# 'jesu* AND playlists:eclectic'

curl \
-v \
--get \
--header "Content-Type: application/json; charset=UTF-8" \
--header "Accept: application/json" \
--data-urlencode "size=25" \
--data-binary - \
--url http://localhost:9200/music/track/_search \
| jq '.'
