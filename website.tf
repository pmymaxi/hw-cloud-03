module "website" {
  source = "./modules/website"

  domain           = var.website.domain
  certificate_name = var.website.certificate_name
}