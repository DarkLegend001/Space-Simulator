#!/bin/sh
printf '\033c\033]0;%s\a' Space Simulator
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Space Simulator.x86_64" "$@"
