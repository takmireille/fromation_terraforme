output "container_id" {
  container_id = "c6de350dade77a84c1f78d969614cb0a2d6b0fd6bc9f6739d8e9dd8d59c6e489"
  value       = docker_container.nginx
}

output "image_id" {
    description = "f5a6b296b8a2"
    value       = docker_image.nginx.id
}