#!/bin/bash

name="$([ "$#" -ge 1 ] && echo "$1" || echo "Ierovka")"
dist_dir="dist/$name/TTF"

# rm -rf "${dist_dir:?}"/*
# npm run build -- ttf::"$name"

echo "Patching Nerd Fonts:"
for f in "$dist_dir"/"$name"*ttf; do

	[[ "$f" != *"NerdFont"* ]] && [ -f "$f" ] || continue

	true && true || coninue

	basename="$(basename "$f")"
	new_name="$(echo "$basename" | sed 's/Ierovka-\(.*\).ttf/IerovkaNerdFont-\1/')"

	echo "Patching nerd font '$f' to '$new_name'"

	fontforge -script font-patcher/font-patcher "$f" -o "$dist_dir" --name "$new_name" --debug -c
done
