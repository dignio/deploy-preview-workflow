set -euxo pipefail

app_name="$1"
# $2 = app_name_postfix=

full_app_name="$app_name"

# Prepend the postfix if it exists
if [ ! -z "$2" ]
then
    full_app_name+="-$2"
fi

echo "::set-output name=full_name::$full_app_name"
