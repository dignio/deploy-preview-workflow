# Dignio reusable workflows

A public repository for reusable workflows.

## Workflow usage

### Deploy preview

For the descriptions of the different inputs and secrets, have a look at [.github/workflows/deploy-preview.yaml](.github/workflows/deploy-preview.yaml)

```yaml
on:
  # IMPORTANT: It has to have this in your workflow to actually work
  pull_request:
    types: [opened, reopened, synchronize, closed]

jobs:
  deploy-preview:
    uses: dignio/workflows/.github/workflows/deploy-preview.yaml@main
    with:
      app_name: prevent-ui
      service_type: webservice
      port: 80
      docker_build_args: |
        "API_BASE_PATH=https://dev.dignio.com/api"
      path: /
    secrets:
      aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      kube_config: ${{ secrets.KUBE_CONFIG }}
      github_app_private_key: ${{ secrets.GITHUB_APP_PRIVATE_KEY }}
```


## LICENSE
See [LICENSE](LICENSE)
