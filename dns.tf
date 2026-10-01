module "dns" {
  source = "./modules/dns"

  folder_id = var.folder_id
  zone_name = var.website.dns.zone_name
  zone      = var.website.dns.zone
  public    = var.website.dns.public

  records = merge(
    var.website.dns.records,

    {
      certificate = {
        name        = module.website.certificate_challenge.name
        type        = module.website.certificate_challenge.type
        ttl         = var.website.dns.ttl
        data        = [module.website.certificate_challenge.value]
        description = "Certificate Manager DNS challenge"
      }
    }
  )
}