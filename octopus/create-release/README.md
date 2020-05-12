# Octopus CLI Create Release action

This GitHub Action (using the `octopusdeploy/octo` docker container) allows you to create a release, and optionally deploy it to one or more environments.

## Inputs

### Release creation options
  - `project`: Name or ID of the project.
  - `package_version`: Default version number of all packages to use for this release. Override per-package using `input_package`.
  - `version`: Release number to use for the new release.
  - `channel`: Name or ID of the channel to use for the new release. Omit this argument to automatically select the best channel.
  - `package`: Version number to use for a package in the release. Format: `StepName:Version` or `PackageID:Version` or `StepName:PackageName:Version`. `StepName`, `PackageID`, and `PackageName` can be replaced with an `*`. An `*` will be assumed for `StepName`, `PackageID`, or `PackageName` if they are omitted.
  - `packages_folder`: A folder containing NuGet packages from which we should get versions.
  - `release_notes`: Release Notes for the new release. Styling with Markdown is supported.
  - `release_notes_file`: Path to a file that contains Release Notes for the new release. Supports Markdown files.
  - `ignore_existing`: Don't create this release if there is already one with the same version number.
  - `ignore_channel_rules`: Create the release ignoring any version rules specified by the channel.
  - `package_prerelease`: Pre-release for latest version of all packages to use for this release.
  - `what_if`: Perform a dry run but don't actually create/deploy release.

### Deployment
  - `deployment_progress`: Show progress of the deployment
  - `deployment_force_package_download`: Whether to force downloading of already installed packages. Default: `false`.
  - `wait_for_deployment`: Whether to wait synchronously for deployment to finish.
  - `deployment_timeout`: Specifies maximum time (timespan format) that the console session will wait for the deployment to finish. Default `00:10:00`. This will not stop the deployment. Requires `wait_for_deployment` parameter set.
  - `deployment_cancel_on_timeout`: Whether to cancel the deployment if the deployment timeout is reached. Default: `false`.
  - `deployment_check_sleep_cycle`: Specifies how much time (timespan format) should elapse between deployment status checks. Default: `00:00:10`.
  - `deployment_guided_failure`: Whether to use guided failure mode. Valid options are `True` or `False`. Default: setting from environment in Octopus.
  - `deployment_specific_machines`: A comma-separated list of machine names to target in the deployed environment. If not specified all machines in the environment will be considered.
  - `deployment_exclude_machines`: A comma-separated list of machine names to exclude in the deployed environment. If not specified all machines in the environment will be considered.
  - `deployment_force`: If a project is configured to skip packages with already-installed versions, override this setting to force re-deployment. Default: `false`.
  - `deployment_skip_steps`: A comma-separated list of step names to skip.
  - `deployment_no_raw_log`: Don't print the raw log of failed tasks.
  - `deployment_variable`: Redirect the raw log of failed tasks to a file
  - `deploy_at`: A comma-separated list of values for any prompted variables in the format `Label:Value`. For JSON values, embedded quotation marks should be escaped with a backslash.
  - `no_deploy_after`: Time at which deployment should start (scheduled deployment), specified as any valid DateTimeOffset format, and assuming the time zone is the current local time zone.
  - `deployment_tenant`: A comma-separated list of tenants to create a deployment for or use `*` wildcard to deploy to all tenants who are ready for this release (according to lifecycle).
  - `deployment_tenant_tag`: A comma-separated list of tenant tags for tenants to create a deployment for.
  - `deploy_to`: A comma-separated list of environment names or IDs of the environments to automatically deploy to, e.g., `'Production'` or `'Environments-1','Environments-2'`.

### Common options
- `octopus_server`: The base URL for your Octopus Server, e.g., 'https://octopus.example.com/'.
- `octopus_api_key`: Your API key. Get this from the user profile page.
- `debug`: Enable debug logging
- `ignore_ssl_errors`: Set this flag if your Octopus Server uses HTTPS but the certificate is not trusted on this machine. Any certificate errors will be ignored. **WARNING:** this option may create a security vulnerability.
- `timeout`: Timeout in seconds for network operations. Default is `600`
- `space`: The name or ID of a space within which this command will be executed. The default space will be used if it is omitted.
- `log_level`: The log level. Valid options are `verbose`, `debug`, `information`, `warning`, `error` and `fatal`. Default: `debug`

## Example workflow - create release in Octopus

On every `push` to a tag, [create a release](https://octopus.com/docs/octopus-rest-api/octopus-cli/create-release#Creatingreleases-Basicexamples)

```yaml
on: 
  push:
    tag: 
      '*'

jobs:

  create-release:
    runs-on: [ubuntu-latest]

    steps:
      - name: 'Create release'
        uses: hnrkndrssn/actions/octopus/create-release@master
        with:
          project: 'MyProject'
          package_version: '1.0.0'
          octopus_server: ${{ secrets.OCTOPUS_URL }}
          octopus_api_key: ${{ secrets.OCTOPUS_API_KEY }}
```
