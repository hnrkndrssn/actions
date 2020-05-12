# Octopus CLI Push action

This GitHub Action (using the `octopusdeploy/octo` docker container) pushes a package (.nupkg, .zip, .tar.gz, etc.) package to the built-in NuGet repository in an Octopus Server.

## Inputs

### Package pushing options
- `package`: Package file to push. Specify multiple packages by separating with a `,`.
- `overwrite_mode`: If the package already exists in the repository, the default behavior is to reject the new package being pushed. Valid options are `FailIfExists`, `OverwriteExisting` or `IgnoreIfExists`. Default: `FailIfExists`.
- `use_delta_compression`: Allows disabling of delta compression when uploading packages to the Octopus Server. Default: `true`.

### Common options
- `octopus_server`: The base URL for your Octopus Server, e.g., 'https://octopus.example.com/'.
- `octopus_api_key`: Your API key. Get this from the user profile page.
- `debug`: Enable debug logging
- `ignore_ssl_errors`: Set this flag if your Octopus Server uses HTTPS but the certificate is not trusted on this machine. Any certificate errors will be ignored. **WARNING:** this option may create a security vulnerability.
- `timeout`: Timeout in seconds for network operations. Default is `600`
- `space`: The name or ID of a space within which this command will be executed. The default space will be used if it is omitted.
- `log_level`: The log level. Valid options are `verbose`, `debug`, `information`, `warning`, `error` and `fatal`. Default: `debug`

## Example workflow - push a package to Octopus

On every `push` to a tag, [pushing a package](https://octopus.com/docs/packaging-applications/package-repositories/built-in-repository#pushing-packages-to-the-built-in-repository)

```yaml
on: 
  push:
    tag: 
      '*'

jobs:

  push-package:
    runs-on: [ubuntu-latest]

    steps:
      - name: 'Push package to Octopus'
        uses: hnrkndrssn/actions/octopus/push@master
        with:
          package: 'path/to/package.version.nupkg'
          octopus_server: ${{ secrets.OCTOPUS_URL }}
          octopus_api_key: ${{ secrets.OCTOPUS_API_KEY }}
```
