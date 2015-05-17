#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--request GET \
--header "Content-Type: application/json; charset=UTF-8" \
--header "Accept: application/json" \
--data @- \
--url http://localhost:9200/music/track/_search?search_type=count \
| jq '.'
