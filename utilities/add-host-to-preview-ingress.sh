# Check if the ingress host exists
EXIST=$(${{ steps.kubectl.outputs.kubectl-path }} get ingress preview-ingress --namespace=${{ env.NAMESPACE }} --output=json | jq '.spec.rules | map(.host == "${{ steps.app_name.outputs.full_name }}-${{ steps.letter_case.outputs.kebab }}.preview.dignio.dev") | index(true)')

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
        "host": "${{ steps.app_name.outputs.full_name }}-${{ steps.letter_case.outputs.kebab }}.preview.dignio.dev",
        "http": {
            "paths": [{
                "backend": {
                    "service": {
                        "name": "${{ steps.app_name.outputs.full_name }}-${{ steps.letter_case.outputs.kebab }}-preview",
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
EOF )

    ${{ steps.kubectl.outputs.kubectl-path }} patch ingress preview-ingress --namespace=${{ env.NAMESPACE }} --type='json' -p="$patch"
else
    echo "Preview URL already exists. Skipping."
fi
