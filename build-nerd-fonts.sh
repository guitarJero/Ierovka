#!/bin/bash

name="$([ "$#" -ge 1 ] && echo "$1" || echo "Ierovka")"
dist_dir="dist/$name/TTF"
rm -rf "$dist_dir"/*

npm run build -- ttf::"$name"

echo "Patching Nerd Fonts:"
for f in "$dist_dir"/"$name"*ttf; do
	if [[ "$f" == *"NerdFont"* ]]; then
		continue
	fi
	fontforge -script font-patcher/font-patcher "$f" -o "$dist_dir"
done
