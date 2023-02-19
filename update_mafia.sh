#!/bin/bash

api_latest_info_url="https://api.github.com/repos/kolmafia/kolmafia/releases/latest"

latest=$(curl -s ${api_latest_info_url})

filename=$(echo ${latest} | jq '.assets[] | select(.name | match(".jar$")) | .name')
browser_download_url=$(echo ${latest} | jq '.assets[] | select(.name | match(".jar$")) | .browser_download_url')


filename=${filename//\"/}
browser_download_url=${browser_download_url//\"/}
echo ${filename}
echo ${browser_download_url}

download_command="curl -L -O ${browser_download_url}"
echo "curl -L -O ${browser_download_url}"
echo "Downloading new Mafia file..."

curl -L -O ${browser_download_url}
EC=$?
echo "Status: ${EC}"
if [ "${EC}" -eq "0" ]; then
  mv KoLMafia.jar KoLMafia.jar.bak
  cp ${filename} KoLMafia.jar
  rm KoLMafia.jar.bak
fi
