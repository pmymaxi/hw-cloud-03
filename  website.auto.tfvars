website = {
  domain           = "nodnix.tech"
  bucket_name      = "nodnix.tech"
  certificate_name = "nodnix-tech"

  index_document = "index.html"
  error_document = "error.html"

  index_source = "/templates/index.html"
  error_source = "/templates/error.html"

  anonymous_access = {
    read        = true
    list        = true
    config_read = true
  }

  versioning = true

  dns = {
    zone_name = "nodnix-tech-zone"
    zone      = "nodnix.tech."
    public    = true
    ttl       = 600

    records = {
      website = {
        name        = "nodnix.tech."
        type        = "ANAME"
        ttl         = 600
        data        = ["nodnix.tech.website.yandexcloud.net."]
        description = "Static website Object Storage"
      }
    }
  }
}