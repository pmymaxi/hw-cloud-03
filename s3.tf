module "storage" {
  source = "./modules/storage"

  folder_id       = var.folder_id
  service_account = var.service_account
  kms_key         = var.kms_key

  bucket = merge(
    var.bucket,
    {
      (var.website.bucket_name) = {
        versioning = var.website.versioning

        anonymous_access = var.website.anonymous_access

        website = {
          index_document = var.website.index_document
          error_document = var.website.error_document
        }

        https = {
          certificate_id = module.website.certificate_id
        }

        objects = {
          index = {
            key    = var.website.index_document
            source = var.website.index_source
            public = true
          }

          error = {
            key    = var.website.error_document
            source = var.website.error_source
            public = true
          }
        }
      }
    }
  )
}