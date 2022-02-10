# Get the index of the host we want to remove from the ingress
INDEX=$(${{ steps.kubectl.outputs.kubectl-path }} get ingress preview-ingress --namespace=${{ env.NAMESPACE }} --output=json  | jq '.spec.rules | map(.host == "${{ steps.app_name.outputs.full_name }}-${{ steps.letter_case.outputs.kebab }}.preview.dignio.dev") | index(true)')

if [ "$INDEX" != "null" ]
then
    echo "Deleting host from preview ingress."

    # Remove the host from the ingress by using a remove operation
    ${{ steps.kubectl.outputs.kubectl-path }} patch ingress preview-ingress --namespace=${{ env.NAMESPACE }} --type='json' -p='[ { "op":"remove","path":"/spec/rules/'"$INDEX"'" } ]'
fi
