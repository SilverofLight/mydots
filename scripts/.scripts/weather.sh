#!/bin/bash

# Default city is Wuhan, but can be overridden by command line argument
CITY=${1:-"Wuhan"}

# Get weather information
weather=$(curl -s "wttr.in/$CITY?format=Location:%l\nTemp:%t\nWeather:%c" 2>/dev/null)

# Debug output
# echo "Debug: Weather info: $weather"

if [ -n "$weather" ] && [ $? -eq 0 ]; then
    # Send notification
    notify-send "Weather Report" "$weather" -i weather-few-clouds -u normal
else
    # Send error notification if failed
    notify-send "Weather Error" "Please check your network connection or city name" -i weather-severe-alert
fi
