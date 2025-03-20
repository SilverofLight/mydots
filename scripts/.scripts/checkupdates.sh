#!/bin/bash

pacman -Sy
pacman -Qu | wc -l > /home/silver/Templates/update
