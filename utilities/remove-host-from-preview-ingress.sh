#!/bin/bash

set -euxo pipefail

namespace="$1"
full_name="$2"

# Get the index of the host we want to remove from the ingress
INDEX=$(kubectl get ingress previews-ingress --namespace=$namespace --output=json  | jq '.spec.rules | map(.host == "'"$full_name"'.preview.dignio.dev") | index(true)')

if [ "$INDEX" != "null" ]
then
    echo "Deleting host from preview ingress."

    # Remove the host from the ingress by using a remove operation
    kubectl patch ingress previews-ingress --namespace=$namespace --type='json' -p='[ { "op":"remove","path":"/spec/rules/'"$INDEX"'" } ]'
fi
