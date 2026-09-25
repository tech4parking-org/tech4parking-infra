output "vagasaservice_api_ecs_cluster_id" {
  value = aws_ecs_cluster.vagasaservice_api_cluster.id
}

output "vagasaservice_api_ecs_cluster_name" {
  value = aws_ecs_cluster.vagasaservice_api_cluster.name
}

output "vagasaservice_website_ecs_cluster_id" {
  value = aws_ecs_cluster.vagasaservice_website_cluster.id
}

output "vagasaservice_website_ecs_cluster_name" {
  value = aws_ecs_cluster.vagasaservice_website_cluster.name
}