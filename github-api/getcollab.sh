#!/bin/bash

# Check if the correct number of arguments is provided

# $#: This special variable holds the number of arguments passed to the script.
# -ne: This stands for "not equal".
# 4: The script expects exactly 4 arguments.
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <owner> <repo> <username> <token>"
  exit 1
fi

# Assign input arguments to variables
OWNER=$1
REPO=$2
USERNAME=$3
TOKEN=$4

# Function to get collaborators
get_collaborators() {
  curl -s -u "${USERNAME}:${TOKEN}" "https://api.github.com/repos/${OWNER}/${REPO}/collaborators"
}

# Fetch collaborators
COLLABORATORS=$(get_collaborators)

# Check if the request was successful
#   $?: This special variable holds the exit status of the last executed command. In Unix-like systems, a status of 0 generally means that the command was successful, while a non-zero status indicates an error.

if [ $? -ne 0 ]; then
  echo "Error fetching collaborators"
  exit 1
fi

# Parse and display the collaborators
echo "Users with access to the repository ${OWNER}/${REPO}:"
echo "$COLLABORATORS" | jq -r '.[].login'

# Note: jq is a JSON parser, make sure it's installed on your system.
# You can install it using your package manager, e.g., sudo apt-get install jq (on Debian/Ubuntu).

