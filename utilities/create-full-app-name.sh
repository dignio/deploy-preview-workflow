#!/bin/bash

set -exo pipefail

app_name="${{ inputs.app_name }}"
app_name_postfix="${{ inputs.app_name_postfix}}"

full_app_name="$app_name"

# Prepend the postfix if it exists
if [ ! -z "app_name_postfix" ]
then
    full_app_name+="-app_name_postfix"
fi

echo "::set-output name=full_name::$full_app_name"
