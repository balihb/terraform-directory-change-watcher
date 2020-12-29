output "files_with_hash" {
  value       = local.merged_fileset_with_hash
  description = "A single string containing all the checked files with the hash"
}

output "id" {
  value       = null_resource.merged_fileset_with_hash.id
  description = "The resource id that can be watched for change"
}
