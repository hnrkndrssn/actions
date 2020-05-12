# Octopus CLI Create Release action

This GitHub Action (using the `octopusdeploy/octo` docker container) allows you to deploy a release to one or more environments.

## Inputs

### Deployment options
  - `project`: Name or ID of the project.
  - `release_number`: Version number of the release to deploy. Or specify `latest` for the latest release.
  - `deploy_to`: A comma-separated list of environment names or IDs of the environments to automatically deploy to, e.g., `'Production'` or `'Environments-1','Environments-2'`.
  - `channel`: Name or ID of the channel to use for the new release. Omit this argument to automatically select the best channel.
  - `show_progress`: Show progress of the deployment
  - `force_package_download`: Whether to force downloading of already installed packages. Default: `false`.
  - `wait_for_deployment`: Whether to wait synchronously for deployment to finish.
  - `deployment_timeout`: Specifies maximum time (timespan format) that the console session will wait for the deployment to finish. Default `00:10:00`. This will not stop the deployment. Requires `wait_for_deployment` parameter set.
  - `cancel_on_timeout`: Whether to cancel the deployment if the deployment timeout is reached. Default: `false`.
  - `check_sleep_cycle`: Specifies how much time (timespan format) should elapse between deployment status checks. Default: `00:00:10`
  - `use_guided_failure`: Whether to use guided failure mode. Valid options are `True` or `False`. Default: setting from environment in Octopus.
  - `specific_machines`: A comma-separated list of machine names to target in the deployed environment. If not specified all machines in the environment will be considered.
  - `exclude_machines`: A comma-separated list of machine names to exclude in the deployed environment. If not specified all machines in the environment will be considered.
  - `force`: If a project is configured to skip packages with already-installed versions, override this setting to force re-deployment. Default: `false`.
  - `skip_steps`: A comma-separated list of step names to skip.
  - `no_raw_log`: Don't print the raw log of failed tasks
  - `raw_log_file`: Redirect the raw log of failed tasks to a file
  - `prompted_variables`: A comma-separated list of values for any prompted variables in the format `Label:Value`. For JSON values, embedded quotation marks should be escaped with a backslash.
  - `update_variables`: Overwrite the variable snapshot for the release by re-importing the variables from the project.
  - `deploy_at`: Time at which deployment should start (scheduled deployment), specified as any valid DateTimeOffset format, and assuming the time zone is the current local time zone.
  - `no_deploy_after`: Time at which scheduled deployment should expire, specified as any valid DateTimeOffset format, and assuming the time zone is the current local time zone.
  - `tenants`: A comma-separated list of tenants to create a deployment for or use `*` wildcard to deploy to all tenants who are ready for this release (according to lifecycle).
  - `tenant_tags`: A comma-separated list of tenant tags for tenants to create a deployment for.

### Common options
- `octopus_server`: The base URL for your Octopus Server, e.g., 'https://octopus.example.com/'.
- `octopus_api_key`: Your API key. Get this from the user profile page.
- `debug`: Enable debug logging
- `ignore_ssl_errors`: Set this flag if your Octopus Server uses HTTPS but the certificate is not trusted on this machine. Any certificate errors will be ignored. **WARNING:** this option may create a security vulnerability.
- `timeout`: Timeout in seconds for network operations. Default is `600`
- `space`: The name or ID of a space within which this command will be executed. The default space will be used if it is omitted.
- `log_level`: The log level. Valid options are `verbose`, `debug`, `information`, `warning`, `error` and `fatal`. Default: `debug`

## Example workflow - deploy a release in Octopus

On every `push` to a tag, [deploy a release](https://octopus.com/docs/octopus-rest-api/octopus-cli/deploy-release#Deployingreleases-Basicexamples)

```yaml
on: 
  push:
    tag: 
      '*'

jobs:

  create-release:
    runs-on: [ubuntu-latest]

    steps:
      - name: 'Deploy release'
        uses: hnrkndrssn/actions/octopus/create-release@master
        with:
          project: 'MyProject'
          release_number: '1.0.0'
          deploy_to: 'Test'
          octopus_server: ${{ secrets.OCTOPUS_URL }}
          octopus_api_key: ${{ secrets.OCTOPUS_API_KEY }}
```
