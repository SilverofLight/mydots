#!/bin/bash
curl -s -X GET 'http://127.0.0.1:9090/proxies' -H 'Authorization: Bearer woshi1gg' | jq | grep "now" | awk 'NR==12'| sed 's/.*: "\(.*\)",/\1/'
