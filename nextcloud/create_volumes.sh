#!/usr/bin/env bash
# Includes assistance from OpenAI's GPT-3.5 model ( https://openai.com/ )
#
# Creates directories (prefix DIR_) and files (FILE_) from docker_compose .env file
# Directories used as Docker volumes



env_file=".env"
echo "Using env definition file: $env_file"



# Check if the .env file exists
if [ -f "$env_file" ]; then
    # Read the .env file line by line
    while IFS='=' read -r key path; do
        # Check if the path is not empty
        if [ -n "$path" ]; then
            # Check if the path exists
            if [ ! -e "$path" ]; then
                #Extract the indicator (DIR or FILE) from the key
                indicator="${key%%_*}"
                if [ "$indicator" = "DIR" ]; then
                    # It's a directory, create missing directories
                    mkdir -p "$path"
                    echo "Created: $path for $key"
                elif [ "$indicator" = "FILE" ]; then
                    # It's a file, create missing directories and the file
                    mkdir -p "$(dirname "$path")"
                    touch "$path"
                    echo "Created path and file: $path for $key"
                else
                    echo "Unknown indicator for: $path"
                fi
            else
                # The path already exists
                echo "Exists, done nothing: $path for $key"
            fi
        fi
    done < "$env_file"
else
    echo ".env file not found."
fi
