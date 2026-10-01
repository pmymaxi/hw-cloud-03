output "website" {
  description = "Static website certificate information"

  value = {
    certificate_id     = module.website.certificate_id
    certificate_name   = module.website.certificate_name
    certificate_status = module.website.certificate_status
    domain             = module.website.domain
    challenges         = module.website.challenges
  }
}