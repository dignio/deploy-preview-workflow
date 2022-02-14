set -euxo pipefail

app_name="$1"
app_name_postfix="$2"

full_app_name="$app_name"

# Prepend the postfix if it exists
[[ ! -z "$2" ]] && full_app_name+="-$2"

echo "::set-output name=full_name::$full_app_name"
