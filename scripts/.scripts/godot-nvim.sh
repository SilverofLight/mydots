#!/bin/bash

if [ -e /tmp/godot.nvim ]; then
  exec /bin/nvim "$@"
else
  exec /bin/kitty -T "godot_nvim" -e nvim "$@"
fi
