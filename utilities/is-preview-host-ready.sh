#!/bin/bash

set -euxo pipefail

full_name="$1"
input_path="$2"

# Run curl 20 times with a retry delay of 15 seconds.
# For success it will exit with the code 0, and for failure with the code 6.
curl --retry 20 --retry-delay 15 --no-buffer --head "https://$full_name.preview.dignio.dev$input_path"
