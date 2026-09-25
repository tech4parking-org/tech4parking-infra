# Certificado SSL
resource "aws_acm_certificate" "cert" {
  domain_name       = "vagasaservice.com.br"
  validation_method = "DNS"

  subject_alternative_names = [
    "www.vagasaservice.com.br",
  ]

  tags = {
    Name = "vagasaservice-certificate"
  }
}
