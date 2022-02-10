kubectl="$1"
namespace="$2"
full_name="$3"
branch_name_kebab_case="$4"
app_port=$5
app_path="$6"

# Check if the ingress host exists
EXIST=$($kubectl get ingress preview-ingress --namespace=$namespace --output=json | jq '.spec.rules | map(.host == "$full_name-$branch_name_kebab_case.preview.dignio.dev") | index(true)')

# If the preview ingress does not have the host name, add it.
if [ "$EXIST" == "null" ]
then
    echo "Creating a preview URL."

    # This patch will add the preview host to the ingress rules
    # Extract example from the preview ingress:

    # spec:
    #   rules:
    #   - host: the-preview-branch.preview.dignio.dev
    #     http:
    #     paths:
    #       - path: /
    #         pathType: Prefix
    #         backend:
    #           service:
    #             name: the-preview-branch
    #             port:
    #               number: 80

 # Transform this EOF to a single line by using tr. Else the kubectl patch will think it is multiline and fail.
patch=$(cat <<EOF | tr -d '\n'
[{
    "op": "add",
    "path": "/spec/rules/-",
    "value": {
        "host": "$full_name-$branch_name_kebab_case.preview.dignio.dev",
        "http": {
            "paths": [{
                "backend": {
                    "service": {
                        "name": "$full_name-$branch_name_kebab_case-preview",
                        "port": {
                            "number": $app_port
                        }
                    }
                },
                "path": "$app_path",
                "pathType": "Prefix"
            }]
        }
    }
}]
EOF
)

    $kubectl patch ingress preview-ingress --namespace=$namespace --type='json' -p="$patch"
else
    echo "Preview URL already exists. Skipping."
fi
