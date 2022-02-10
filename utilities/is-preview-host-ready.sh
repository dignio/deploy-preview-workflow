# Run curl 20 times with a retry delay of 15 seconds.
# For success it will exit with the code 0, and for failure with the code 6.
curl --retry 20 --retry-delay 15 --no-buffer --silent --output /dev/null "https://${{ steps.app_name.outputs.full_name }}-${{ steps.letter_case.outputs.kebab }}.preview.dignio.dev${{ inputs.path }}"
