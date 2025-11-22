#!/usr/bin/env bash

# toggle fade between low opacity (0.1) and normal (1.0)
state_file="/tmp/hypr_fade_state"

if [[ -f "$state_file" ]]; then
  # reset to normal
  for win in $(hyprctl clients -j | jq -r '.[].address'); do
    hyprctl dispatch opacity 1.0 "$win"
  done
  rm "$state_file"
else
  # fade everything
  for win in $(hyprctl clients -j | jq -r '.[].address'); do
    hyprctl dispatch opacity 0.1 "$win"
  done
  touch "$state_file"
fi
