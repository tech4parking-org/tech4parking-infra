# tech4parking-infra

Infraestrutura AWS do Tech4Parking (app de reserva de vagas "vagasaservice"), em Terraform.

## Estrutura

- `terraform/modules.tf`: composição dos módulos
- `terraform/modules/`: `application` (ECS), `compute` (load balancers, security groups), `content-delivery` (ACM, Route53), `database` (DynamoDB), `identity-compliance` (IAM), `internet-of-things` (regra IoT), `services` (Lambda, API Gateway, ECR, SNS, website), entre outros

## Repositórios relacionados

- [tech4parking-back](https://github.com/tech4parking-org/tech4parking-back): código da Lambda `process_car_parking` (a imagem é publicada no ECR criado aqui)
- [tech4parking-front](https://github.com/tech4parking-org/tech4parking-front): site Next.js

## Uso

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Variáveis sensíveis vão em `*.tfvars` (ignorados pelo git).
