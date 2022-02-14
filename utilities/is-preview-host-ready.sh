#!/bin/bash

set -exo pipefail

full_name="$1"
input_path="$2"

# Sleep to make sure everything is ready before we run the curl command
sleep 5s

# Run curl 20 times with a retry delay of 15 seconds.
# For success it will exit with the code 0, and for failure with the code 6.
curl --retry 20 --retry-delay 15 --no-buffer --silent --output /dev/null "https://$full_name.preview.dignio.dev$input_path"
