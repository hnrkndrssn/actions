# Octopus CLI Pack action

This GitHub Action (using the `octopusdeploy/octo` docker container) creates a package (.nupkg or .zip) from files on disk, without needing a .nuspec or .csproj.

## Inputs

### Basic options
- `package_id`: The ID of the package; e.g. `MyCompany.MyApp`.
- `format`: Package format. Valid options are: `NuPkg`, `Zip`. Default: `NuPkg`
- `version`: The version of the package; must be a valid SemVer. Default: `<year>.<month>.<day>.<hour*10000 + minute*100 + second>`
- `out_folder`: The folder into which the generated NuPkg file will be written. Default: `.`
- `base_path`: The root folder containing files and folders to pack. Default: `.`
- `log_level`: The log level. Valid options are: `verbose`, `debug`, `information`, `warning`, `error` and `fatal`. Default: `debug`
- `verbose`: Verbose output. Default: `false`

### NuGet package options
- `author`: Add an author to the package metadata. Add multiple authors by separating them with a `,`. Default: current user.
- `title`: The title of the package.
- `description`: A description of the package. Default: `A deployment package created from files on disk.`
- `release_notes`: Release notes for this version of the package.
- `release_notes_file`: A file containing release notes for this version of the package.

### Zip package options
- `compression_level`: Set compression level of package. Valid options are `none`, `fast`, `optimal`. Default `optimal`.

### Advanced options

- `include`: Add a file pattern to include, relative to the base path e.g. `/bin/*.dll`. Specify multiple file patterns by separating them with a `,`. Default: `**`
- `overwrite`: Allow an existing package file of the same ID/version to be overwritten. Default: `false`

## Example workflow - package application with all defaults

On every `push` to a tag, [create a package](https://octopus.com/docs/packaging-applications/create-packages/octopus-cli)

```yaml
on: 
  push:
    tag: 
      '*'

jobs:

  package-application:
    runs-on: [ubuntu-latest]

    steps:
      - name: 'Package application'
        uses: hnrkndrssn/actions/octopus/pack@master
        with:
          package_id: 'MyCompany.MyApp'
```
