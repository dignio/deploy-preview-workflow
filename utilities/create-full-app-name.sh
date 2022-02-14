set -exo pipefail

app_name="$1"
app_name_postfix="$2"

full_app_name="$app_name"

# Prepend the postfix if it exists
if [ ! -z "app_name_postfix" ]
then
    full_app_name+="-app_name_postfix"
fi

echo "::set-output name=full_name::$full_app_name"
