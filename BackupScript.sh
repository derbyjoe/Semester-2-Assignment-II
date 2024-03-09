#!/bin/bash

# Parse arguments
source_dir="$1"
dest_dir="$2"

# Check if source and destination directories are provided
if [ -z "$source_dir" ] || [ -z "$dest_dir" ]; then
  echo "Usage: $0 <source_directory> <destination_directory>"
  exit 1
fi

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
  echo "Error: Source directory '$source_dir' does not exist or is not a directory."
  exit 1
fi

# Create destination directory if it doesn't exist
if [ ! -d "$dest_dir" ]; then
  mkdir -p "$dest_dir"
fi

# Create backup filename with timestamp
backup_file="$dest_dir/backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Create tar archive of the source directory
tar -czf "$backup_file" "$source_dir"

echo "Backup created: $backup_file"
