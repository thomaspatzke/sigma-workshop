#!/bin/bash

jq -c '.hits.hits[] | del(._score) | { "index": (. | del(._source))  }, ._source' $1
