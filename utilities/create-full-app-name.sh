#!/bin/bash

set -euxo pipefail

app_name=$1
app_name_postfix=$2
override_hostname=$3
kebab_branch_name=$4



if [ ! -z "$override_hostname" ]
then
    full_app_name="$override_hostname"
else
    full_app_name="$app_name"
    # Prepend the postfix if it exists
    if [ ! -z "$app_name_postfix" ]
    then
        full_app_name+="-$app_name_postfix"
    fi

    full_app_name+="-$kebab_branch_name"
fi
# Set a limit to 63 characters as k8s has the final say in this.
# Remove - if that is the last character
full_app_name="$(echo $full_app_name | cut -c -63 | sed 's/-$//')"


echo "::set-output name=full_name::$full_app_name"
