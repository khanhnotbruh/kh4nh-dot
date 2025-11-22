#!/bin/bash

if hyprctl monitors | grep -q "DPMS: on"; then
  hyprctl dispatch dpms off
else
  hyprctl dispatch dpms on
fi
