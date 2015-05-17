#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

curl \
-s \
--get \
--header "Accept: application/json" \
--url http://localhost:9200/music/_mapping \
| jq '.'
