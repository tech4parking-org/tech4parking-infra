# Configuração da Zona DNS
resource "aws_route53_zone" "vagasaservice_zone" {
  name = "vagasaservice.com.br"
}