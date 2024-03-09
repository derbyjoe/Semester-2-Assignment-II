#!/bin/bash

# Default value for number of entries
num_entries=8

# Parse arguments
while getopts ":d:n:" opt; do
  case $opt in
    d)
      list_all=true
      directory="$OPTARG"
      ;;
    n)
      num_entries="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Shift the arguments to handle directory as the last argument
shift $((OPTIND -1))

# Check if directory argument is provided
if [ -z "$1" ]; then
  echo "Error: Directory argument is missing."
  exit 1
fi

directory="$1"

# Check if the directory exists
if [ ! -d "$directory" ]; then
  echo "Error: $directory does not exist or is not a directory."
  exit 1
fi

# Display disk usage
if [ "$list_all" = true ]; then
  du -ah "$directory" | sort -rh | head -n "$num_entries"
else
  du -h --max-depth=1 "$directory" | sort -rh | head -n "$num_entries"
fi
