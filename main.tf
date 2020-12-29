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
  merged_fileset_with_hash = concat(
    data.null_data_source.merged_fileset_with_hash_md5.*.outputs.files_with_hash,
    data.null_data_source.merged_fileset_with_hash_sha1.*.outputs.files_with_hash,
    data.null_data_source.merged_fileset_with_hash_sha256.*.outputs.files_with_hash,
    data.null_data_source.merged_fileset_with_hash_sha512.*.outputs.files_with_hash,
    data.null_data_source.merged_fileset_with_hash_base64sha256.*.outputs.files_with_hash,
    data.null_data_source.merged_fileset_with_hash_base64sha512.*.outputs.files_with_hash
  )[0]
}

data "null_data_source" "merged_fileset_with_hash_md5" {
  count = var.hash_algorithm == "md5" ? 1 : 0

  inputs = {
    files_with_hash = join(",", [for fn in local.merged_fileset : "${fn}=${filemd5(fn)}"])
  }
}

data "null_data_source" "merged_fileset_with_hash_sha1" {
  count = var.hash_algorithm == "sha1" ? 1 : 0

  inputs = {
    files_with_hash = join(",", [for fn in local.merged_fileset : "${fn}=${filesha1(fn)}"])
  }
}

data "null_data_source" "merged_fileset_with_hash_sha256" {
  count = var.hash_algorithm == "sha256" ? 1 : 0

  inputs = {
    files_with_hash = join(",", [for fn in local.merged_fileset : "${fn}=${filesha256(fn)}"])
  }
}

data "null_data_source" "merged_fileset_with_hash_sha512" {
  count = var.hash_algorithm == "sha512" ? 1 : 0

  inputs = {
    files_with_hash = join(",", [for fn in local.merged_fileset : "${fn}=${filesha512(fn)}"])
  }
}

data "null_data_source" "merged_fileset_with_hash_base64sha256" {
  count = var.hash_algorithm == "base64sha256" ? 1 : 0

  inputs = {
    files_with_hash = join(",", [for fn in local.merged_fileset : "${fn}=${filebase64sha256(fn)}"])
  }
}

data "null_data_source" "merged_fileset_with_hash_base64sha512" {
  count = var.hash_algorithm == "base64sha512" ? 1 : 0

  inputs = {
    files_with_hash = join(",", [for fn in local.merged_fileset : "${fn}=${filebase64sha512(fn)}"])
  }
}

resource "null_resource" "merged_fileset_with_hash" {
  triggers = {
    merged_fileset_with_hash = local.merged_fileset_with_hash
  }
}
