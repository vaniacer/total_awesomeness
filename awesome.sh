#!/bin/bash

token=$1               # your github token
awesome=${2:-awesome}  # repo type/name to search

die(){ echo $1; exit 1; }

[[ $token   ]] || die "Github token needed!"
[[ $awesome ]] || die "Set repo type/name to search!"

for i in {1..10}; {
    curl -s -H "Authorization: Bearer $token" \
         -H "Accept: application/vnd.github+json" \
         "https://api.github.com/search/repositories?q=$awesome&sort=stars&order=desc&per_page=100&page=$i" | \
    jq -r '.items | .[] | select(.description|test("list")) | "<a href=\""+.html_url+"\">"+.name+"</a> "+.description+"<br>"'
}