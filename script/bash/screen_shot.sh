#!/bin/bash
name="$HOME/Image/screen_shot/$(date -I).png"
region="$(slurp)"
grim -g "$region" $name && firefox $name
