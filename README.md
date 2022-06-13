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
      app_name_postfix: storybook
      service_type: webservice
      aws_role: arn:aws:iam::<account_id>:role/github_actions_kubernetes_deployment_development
      port: 80
      dockerfile: Dockerfile
      docker_build_args: |
        "API_BASE_PATH=https://dev.dignio.com/api"
      path: /
    secrets:
      github_app_private_key: ${{ secrets.GITHUB_APP_PRIVATE_KEY }}
```

### Deploy preview demo

The `Dockerfile` and `index.html` is used in our local `.github/workflows/test-deploy-preview.yaml` to test the deploy preview on PRs.
## LICENSE
See [LICENSE](LICENSE)
