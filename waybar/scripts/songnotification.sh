#!/bin/bash

extract_field() {
  local metadata="$1"
  local field="$2"
  echo "$metadata"| grep -iw "$field" | cut -d' ' -f 3- | sed 's/^[ \t]*//;s/[ \t]*$//'
}

fetch_image() {
  local metadata="$1"
  local img_url=$(echo "$metadata"| grep -iw "artUrl" | cut -d' ' -f 3- | sed 's/^[ \t]*//;s/[ \t]*$//')
  temp_png=$(mktemp).png
  wget -q --no-dns-cache "$img_url" -O "$temp_png"
  echo "$temp_png"
}

metadata=$(playerctl metadata --player=spotifyd)
title=`extract_field "$metadata" "title"`
artist=`extract_field "$metadata" "albumArtist"`
album=`extract_field "$metadata" "album"`
song="Title: ${title}\nArtist: ${artist}\nAlbum: ${album}"
img_path=`fetch_image "$metadata"`

case "${PLAYER_EVENT}" in
  "load")
  notify-send "Currently Playing" "$song" --icon="$img_path" ;;
  "start")
  notify-send "Started playing" "$song" --icon="$img_path" ;;
esac
