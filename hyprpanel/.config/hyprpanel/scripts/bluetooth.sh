#!/bin/bash

# require: upower

path=$(upower -e | grep headset_dev)
if [ -z "$path" ]; then
  echo "ON"
else
  upower -i $path | grep percentage | awk '{print $2}'
fi
