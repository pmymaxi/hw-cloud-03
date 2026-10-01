variable "access_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "env переменная access_key для статистического ключа сервисного аккаунта"
}

variable "secret_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "env переменная secret_key для статистического ключа сервисного аккаунта"
}

variable "cloud_id" {
  type        = string
  description = "ID облака размещения"
}

variable "folder_id" {
  type        = string
  default     = "ru-central1-a"
  description = "ID каталога размещения"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Регион размещения"
}

variable "service_account" {
  description = "Сервисные аккаунты"

  type = map(object({
    name     = string
    role     = optional(string)
    desc_key = optional(string)
  }))

  default = {}
}

variable "kms_key" {
  description = "KMS ключи для шифрования bucket"

  type = map(object({
    name              = string
    description       = optional(string, "")
    default_algorithm = optional(string, "AES_128")
    rotation_period   = optional(string)
    service_accounts  = optional(list(string), [])
  }))

  default = {}
}

variable "bucket" {
  description = "Yandex Object Storage buckets"

  type = map(object({
    max_size = optional(number)

    versioning = optional(bool, false)

    anonymous_access = optional(object({
      read        = optional(bool, false)
      list        = optional(bool, false)
      config_read = optional(bool, false)
    }), {})

    encryption = optional(object({
      kms_key       = string
      sse_algorithm = optional(string, "aws:kms")
    }))

    objects = optional(map(object({
      key     = string
      source  = optional(string)
      content = optional(string)
      tags    = optional(map(string), {})
      public  = optional(bool, false)
    })), {})

    access = optional(object({
      service_account = string
      role            = optional(string, "storage.viewer")
    }))
  }))

  default = {}
}

variable "website" {
  description = "Параметры статического сайта"

  type = object({
    domain           = string
    bucket_name      = string
    certificate_name = string

    index_document = string
    error_document = string

    index_source = string
    error_source = string

    anonymous_access = object({
      read        = bool
      list        = bool
      config_read = bool
    })

    versioning = bool

    dns = object({
      zone_name = string
      zone      = string
      public    = bool
      ttl       = number

      records = map(object({
        name        = string
        type        = string
        ttl         = number
        data        = list(string)
        description = optional(string)
      }))
    })
  })
}