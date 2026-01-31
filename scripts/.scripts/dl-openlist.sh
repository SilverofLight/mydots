#!/bin/bash

# Download script with -o option support
# Usage: ./dl-openlist.sh <url> [-o <output_filename>]

# Default values
url=""
output_file=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--output)
            if [[ $# -ge 2 ]]; then
                output_file="$2"
                shift 2
            else
                echo "Error: -o requires a filename argument"
                exit 1
            fi
            ;;
        -h|--help)
            echo "Usage: $0 <url> [-o <output_filename>]"
            echo "  <url>: URL to download from"
            echo "  -o, --output: Specify output filename (optional)"
            echo "  -h, --help: Show this help message"
            exit 0
            ;;
        *)
            # First non-option argument is the URL
            if [[ -z "$url" ]]; then
                url="$1"
            else
                echo "Error: Too many arguments. Only one URL is allowed."
                echo "Usage: $0 <url> [-o <output_filename>]"
                exit 1
            fi
            shift
            ;;
    esac
done

# Check if URL was provided
if [[ -z "$url" ]]; then
    echo "Error: URL is required"
    echo "Usage: $0 <url> [-o <output_filename>]"
    exit 1
fi

# If output file not specified, ask user for it
if [[ -z "$output_file" ]]; then
    echo "Enter output filename (press Enter to use default from URL):"
    read -r user_input
    if [[ -n "$user_input" ]]; then
        output_file="$user_input"
    fi
fi

# If still no output file, extract from URL
if [[ -z "$output_file" ]]; then
    # Extract filename from URL
    filename=$(basename "$url")
    # Remove query parameters
    filename=${filename%%\?*}
    # Remove fragment
    filename=${filename%%\#*}
    output_file="$filename"
fi

# Download the file
echo "Downloading from: $url"
echo "Output file: $output_file"

curl -L -H 'User-Agent:pan.baidu.com' -X GET "$url" --output "$output_file"

if [[ $? -eq 0 ]]; then
    echo "Download completed successfully: $output_file"
else
    echo "Download failed!"
    exit 1
fi

