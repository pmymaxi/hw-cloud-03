kms_key = {
  storage_key = {
    name              = "storage-key"
    description       = "KMS key for Object Storage"
    default_algorithm = "AES_256"
    rotation_period   = "8760h"
    service_accounts  = ["admin"]
  }
}


bucket = {
  hw-cloud-02-test-20260929 = {
    versioning = true

    anonymous_access = {
      read        = true
      list        = false
      config_read = false
    }

    encryption = {
      kms_key       = "storage_key"
      sse_algorithm = "aws:kms"
    }

    objects = {
      test_file = {
        key    = "img/picture.jpg"
        source = "/image/picture.jpg"
        public = true

        tags = {
          bucket = "test-img-bucket"
        }
      }
    }
  }
}