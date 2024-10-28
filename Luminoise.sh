#!/bin/sh
echo -ne '\033c\033]0;Luminoise\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Luminoise.x86_64" "$@"
