# terraform-directory-change-watcher

A Terraform module to make it possible to watch a directory for changes.
There are alternate solutions like creating an archive file, but this solution don't require any temporary files.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_directory | Base directory to check the files in. Example value: `"${path.module}/my_directory"` | `string` | n/a | yes |
| fileset\_patterns | A list of fileset patterns to set the files being included in the check. Use `["**"]` to include the whole directory. | `list(string)` | <pre>[<br>  "**"<br>]</pre> | no |
| hash\_algorithm | The algorithm to use to hash the files. Possible values: `md5`, `sha1`, `sha256`, `sha512`, `base64sha256`, `base64sha512`. | `string` | `"md5"` | no |

## Outputs

| Name | Description |
|------|-------------|
| files\_with\_hash | A single string containing all the checked files with the hash |
| id | The resource id that can be watched for change |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
