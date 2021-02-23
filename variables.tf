variable "base_directory" {
  type        = string
  description = "Base directory to check the files in. Example value: `\"$${path.module}/my_directory\"`"
}

variable "fileset_patterns" {
  type        = list(string)
  default     = ["**"]
  description = "A list of fileset patterns to set the files being included in the check. Use `[\"**\"]` to include the whole directory."
}

variable "hash_algorithm" {
  type        = string
  default     = "md5"
  description = "The algorithm to use to hash the files. Possible values: `md5`, `sha1`, `sha256`, `sha512`, `base64sha256`, `base64sha512`."

  validation {
    condition     = contains(["md5", "sha1", "sha256", "sha512", "base64sha256", "base64sha512"], var.hash_algorithm)
    error_message = "Hash algorithm must be one of: md5, sha1, sha256, sha512, base64sha256 or base64sha512."
  }
}
