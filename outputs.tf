output "automq_byoc_env_id" {
  description = "This parameter is used to create resources within the environment. Additionally, all cloud resource names will incorporate this parameter as part of their names. This parameter supports only numbers, uppercase and lowercase English letters, and hyphens. It must start with a letter and is limited to a length of 32 characters."
  value       = var.automq_byoc_env_id
}

output "automq_byoc_endpoint" {
  description = "The endpoint for the AutoMQ environment console. Users can set this endpoint to the AutoMQ Terraform Provider to manage resources through Terraform. Additionally, users can access this endpoint via web browser, log in, and manage resources within the environment using the WebUI."
  value       = "http://${huaweicloud_vpc_eip.automq_byoc_eip.address}:8080"
}

output "automq_byoc_initial_username" {
  description = "The initial username for the AutoMQ environment console. It has the `EnvironmentAdmin` role permissions. This account is used to log in to the environment, create ServiceAccounts, and manage other resources. For detailed information about environment members, please refer to the [documentation](https://docs.automq.com/automq-cloud/manage-identities-and-access/member-accounts)."
  value       = "admin"
}

output "automq_byoc_initial_password" {
  description = "The initial password for the AutoMQ environment console. This account is used to log in to the environment, create ServiceAccounts, and manage other resources. For detailed information about environment members, please refer to the [documentation](https://docs.automq.com/automq-cloud/manage-identities-and-access/member-accounts)."
  value       = huaweicloud_compute_instance.automq_byoc_console.id
}

output "automq_byoc_vpc_id" {
  description = "The VPC ID for the AutoMQ environment deployment."
  value       = local.automq_byoc_vpc_id
}

output "automq_byoc_instance_id" {
  description = "The ECS instance id for AutoMQ Console."
  value       = huaweicloud_compute_instance.automq_byoc_console.id
}

output "automq_byoc_data_bucket_name" {
  description = "The object storage bucket used to store message data generated by applications. The message data Bucket must be separate from the Ops Bucket."
  value       = local.automq_data_bucket
}

output "automq_byoc_ops_bucket_name" {
  description = "The object storage bucket used to store AutoMQ system logs and metrics data for system monitoring and alerts. This Bucket does not contain any application business data. The Ops Bucket must be separate from the message data Bucket."
  value       = local.automq_ops_bucket
}

output "automq_byoc_env_console_ecs_instance_ip" {
  description = "The instance IP of the deployed AutoMQ BYOC control panel. You can access the service through this IP."
  value       = huaweicloud_compute_instance.automq_byoc_console.access_ip_v4
}

output "automq_byoc_env_console_public_subnet_id" {
  description = "The VPC subnet for the AutoMQ environment deployment."
  value       = local.automq_byoc_env_console_public_subnet_id
}

output "automq_byoc_security_group_name" {
  description = "Security group bound to the AutoMQ BYOC service."
  value       = huaweicloud_networking_secgroup.automq_byoc_console_sg.name
}

output "automq_byoc_agency_name" {
  description = "AutoMQ BYOC is bound to the agency of the Console."
  value       = huaweicloud_identity_agency.automq_byoc_agency.name
}

output "automq_byoc_vpc_dns_zone_id" {
  description = "DNS Zone bound to the VPC."
  value       = huaweicloud_dns_zone.private_zone.id
}

output "automq_byoc_env_console_cidr" {
  description = "AutoMQ BYOC security group CIDR."
  value       = var.automq_byoc_env_console_cidr
}

output "automq_byoc_huaweicloud_current_account_id" {
  value = data.huaweicloud_account.current.id
}