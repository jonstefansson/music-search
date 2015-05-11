#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--request GET \
--header "Accept: application/json" \
--url http://localhost:9200/music/_stats \
| jq '.' \
