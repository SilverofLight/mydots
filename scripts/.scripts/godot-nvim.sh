#!/bin/bash

if [ -e /tmp/godot.nvim ]; then
  exec /bin/nvim "$@"
else
  exec /bin/kitty -e nvim "$@"
fi
