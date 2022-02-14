set -exo pipefail

full_name="$1"
branch_name_kebab_case="$2"
input_path="$3"

# Sleep to make sure everything is ready before we run the curl command
sleep 5s

# Run curl 20 times with a retry delay of 15 seconds.
# For success it will exit with the code 0, and for failure with the code 6.
curl --retry 20 --retry-delay 15 --no-buffer --silent --output /dev/null "https://$full_name-$branch_name_kebab_case.preview.dignio.dev$input_path"
