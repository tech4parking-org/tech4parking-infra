module "internet_of_things" {
  source = "./modules/internet-of-things"

  process_car_parking_lambda_arn = module.process_car_parking_lambda.process_car_parking_lambda_arn
}

module "identity_compliance_security" {
  source = "./modules/identity-compliance"

  ecs_website_service_name = var.ecs_website_service_name
  website_bucket_id        = module.storage.website_bucket_id
  website_bucket_name      = module.storage.website_bucket_name
  # cloudfront_oai_id = module.content_delivery.cloudfront_oai_id
  # cloudfront_logging_bucket_arn    = module.storage.cloudfront_logging_bucket_arn
  load_balancer_logging_bucket_id  = module.storage.load_balancer_logging_bucket_id
  load_balancer_logging_bucket_arn = module.storage.load_balancer_logging_bucket_arn

  cognito_stage_name   = var.cognito_stage_name
  cognito_service_name = var.cognito_service_name

  parking_spots_table_arn = module.database.parking_spots_table_arn
}

module "network" {
  source = "./modules/network"

  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

module "compute" {
  source = "./modules/compute"

  aws_region         = var.aws_region
  vpc_id             = module.network.vpc_id
  public_subnet_id1  = module.network.public_subnet_ids[0]
  public_subnet_id2  = module.network.public_subnet_ids[1]
  private_subnet_id1 = module.network.private_subnet_ids[0]
  private_subnet_id2 = module.network.private_subnet_ids[1]

  load_balancer_logging_bucket = module.storage.load_balancer_logging_bucket
}

module "management_governance" {
  source = "./modules/management-governance"

  ecs_website_service_name     = var.ecs_website_service_name
  ecs_task_execution_role_name = module.identity_compliance_security.ecs_task_execution_role_name
}

module "application" {
  source = "./modules/application"

  kms_key_current_arn                         = module.identity_compliance_security.kms_key_current_arn
  ecs_website_service_name                    = var.ecs_website_service_name
  cloudwatch_log_group_website_container_name = module.management_governance.cloudwatch_log_group_website_container_name
}

module "content_delivery" {
  source = "./modules/content-delivery"

  aws_region                     = var.aws_region
  website_load_balancer_dns_name = module.compute.website_load_balancer_dns_name
  website_bucket_name            = module.storage.website_bucket_name
  # cloudfront_logging_bucket_regional_domain_name = module.storage.cloudfront_logging_bucket_regional_domain_name
  # cloudfront_logging_bucket_name                 = module.storage.cloudfront_logging_bucket_name
  website_lb_zone_id = module.compute.website_lb_zone_id
  website_lb_id      = module.compute.website_lb_id
}

module "storage" {
  source = "./modules/storage"

  bucket_name = var.bucket_name
  environment = var.environment
}

module "database" {
  source = "./modules/database"
}

module "process_car_parking_lambda" {
  source = "./modules/services/lambda/process_car_parking"

  iam_role_lambda_exec_arn = module.identity_compliance_security.iam_role_lambda_exec_arn
  parking_spots_table_name = module.database.parking_spots_table_name
}

module "website" {
  source = "./modules/services/website"

  aws_region                     = var.aws_region
  vpc_id                         = module.network.vpc_id
  public_subnet_id1              = module.network.public_subnet_ids[0]
  public_subnet_id2              = module.network.public_subnet_ids[1]
  website_load_balancer_arn      = module.compute.website_load_balancer_arn
  website_load_balancer_dns_name = module.compute.website_load_balancer_dns_name
  ecs_task_execution_role_arn    = module.identity_compliance_security.ecs_task_execution_role_arn
  ecs_public_service_sg_id       = module.compute.ecs_public_service_sg
  acm_certificate_cert_arn       = module.content_delivery.acm_certificate_cert_arn
  route53_record_www_record_name = module.content_delivery.route53_record_www_record_name

  vagasaservice_website_ecs_cluster_id              = module.application.vagasaservice_website_ecs_cluster_id
  vagasaservice_website_ecs_cluster_name            = module.application.vagasaservice_website_ecs_cluster_name
  website_sg_id                                     = module.compute.website_sg_id
  cloudwatch_log_group_website_container_name       = module.management_governance.cloudwatch_log_group_website_container_name
  cloudwatch_log_group_website_task_definition_name = module.management_governance.cloudwatch_log_group_website_task_definition_name
}

# module "delivery-application" {
#   source = "./modules/delivery-application"

#   uri_invoke_arn_lambda_function = module.compute.invoke_arn_lambda_function
# }

# module "AI-analytics" {
#   source = "./modules/AI-analytics"
# }