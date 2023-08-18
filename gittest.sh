#!/bin/bash

die() {
  echo "$1"
  exit 1
}

login=$(git config --get github.user)
token=$(git config --get github.token)

file="$1"
[[ -n "$file" ]] || die "Usage: $0 <file> [<repo>]"

if [[ ! -f "$file" ]]; then
  die "File not found: $file"
fi

file_size=$(stat -c %s "$file")
content_type=$(file -Ib "$file")
file_name=$(basename "$file")

repo=${2:-$(git config --get remote.origin.url | sed -n 's/git@github.com:\(.*\)\.git/\1/p')}

uri="https://github.com/$repo/downloads"
response=$(curl -s -H "Authorization: token $token" -d "login=$login&token=$token&file_size=$file_size&content_type=$content_type&file_name=$file_name" "$uri")

if [[ $(echo "$response" | grep "HTTP/1.1 20") ]]; then
  info=$(echo "$response" | sed -n 's/.*\(http_upload[^"]*\).*/\1/p')
  aws_access_key_id=$(echo "$response" | sed -n 's/.*"accesskeyid":"\([^"]*\)".*/\1/p')
  policy=$(echo "$response" | sed -n 's/.*"policy":"\([^"]*\)".*/\1/p')
  signature=$(echo "$response" | sed -n 's/.*"signature":"\([^"]*\)".*/\1/p')
  acl=$(echo "$response" | sed -n 's/.*"acl":"\([^"]*\)".*/\1/p')

  curl -X POST -F "key=$info" -F "Filename=$file_name" -F "policy=$policy" -F "AWSAccessKeyId=$aws_access_key_id" -F "signature=$signature" -F "acl=$acl" -F "success_action_status=201" -F "Content-Type=$content_type" -F "file=@$file" "http://github.s3.amazonaws.com/"
else
  die "Error: $response"
fi
