#!/bin/bash

# Retrieve environment variables
USERNAME="${USERNAME}"
PASSWORD="${PASSWORD}"
URL="${URL}"

# Ensure required environment variables are set
if [[ -z "$USERNAME" || -z "$PASSWORD" || -z "$URL" ]]; then
  echo "Content-type: text/plain"
  echo ""
  echo "Error: USERNAME, PASSWORD, and URL must be set as environment variables."
  echo "user:${USERNAME}"
  exit 1
fi

# Use curl to send the request
result=$(curl -s -u "${USERNAME}:${PASSWORD}" -L "${URL}")

# Output the result
echo "Content-type: text/calendar"
echo ""
echo "${result}"

