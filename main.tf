# This project is libre, and licenced under the terms of the
# DO WHAT THE FUCK YOU WANT TO PUBLIC LICENCE, version 3.1,
# as published by dtf, July 2019. See the COPYING file or
# https://ph.dtf.wtf/u/wtfplv31 for more details.

locals {
  merged_fileset = sort(
    distinct(
      flatten(
        [for fsp in var.fileset_patterns : fileset(var.base_directory, fsp)]
      )
    )
  )
  merged_fileset_with_hash_md5          = var.hash_algorithm == "md5" ? { for fn in local.merged_fileset : fn => filemd5("${var.base_directory}/${fn}") } : {}
  merged_fileset_with_hash_sha1         = var.hash_algorithm == "sha1" ? { for fn in local.merged_fileset : fn => filesha1("${var.base_directory}/${fn}") } : {}
  merged_fileset_with_hash_sha256       = var.hash_algorithm == "sha256" ? { for fn in local.merged_fileset : fn => filesha256("${var.base_directory}/${fn}") } : {}
  merged_fileset_with_hash_sha512       = var.hash_algorithm == "sha512" ? { for fn in local.merged_fileset : fn => filesha512("${var.base_directory}/${fn}") } : {}
  merged_fileset_with_hash_base64sha256 = var.hash_algorithm == "base64sha256" ? { for fn in local.merged_fileset : fn => filebase64sha256("${var.base_directory}/${fn}") } : {}
  merged_fileset_with_hash_base64sha512 = var.hash_algorithm == "base64sha512" ? { for fn in local.merged_fileset : fn => filebase64sha512("${var.base_directory}/${fn}") } : {}

  merged_fileset_with_hash = merge(
    local.merged_fileset_with_hash_md5,
    local.merged_fileset_with_hash_sha1,
    local.merged_fileset_with_hash_sha256,
    local.merged_fileset_with_hash_sha512,
    local.merged_fileset_with_hash_base64sha256,
    local.merged_fileset_with_hash_base64sha512
  )
}

resource "null_resource" "merged_fileset_with_hash" {
  triggers = local.merged_fileset_with_hash
}
