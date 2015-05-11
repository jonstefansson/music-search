#!/usr/bin/env bash

basedir=${TM_DIRECTORY:-$(pwd)}

cat "${basedir}/output/album-classical.json" \
| jq -r '.facets["album-facets"].terms[] | .term'
