set -exo pipefail

kubectl="$1"
namespace="$2"
full_name="$3"
branch_name_kebab_case="$4"

# Get the index of the host we want to remove from the ingress
INDEX=$($kubectl get ingress preview-ingress --namespace=$namespace --output=json  | jq '.spec.rules | map(.host == "$full_name-$branch_name_kebab_case.preview.dignio.dev") | index(true)')

if [ "$INDEX" != "null" ]
then
    echo "Deleting host from preview ingress."

    # Remove the host from the ingress by using a remove operation
    $kubectl patch ingress preview-ingress --namespace=$namespace --type='json' -p='[ { "op":"remove","path":"/spec/rules/'"$INDEX"'" } ]'
fi
