# HuaweiCloud AutoMQ BYOC Environment Terrafrom module

![Preview](https://img.shields.io/badge/Lifecycle_Stage-Preview-blue?style=flat&logoColor=8A3BE2&labelColor=rgba)

This module is designed for deploying the AutoMQ BYOC (Bring Your Own Cloud) environment using the HuaweiCloud Provider within an HuaweiCloud environment.

Upon completion of the installation, the module will output the endpoint of the AutoMQ BYOC environment along with the initial username and password. Users can manage the resources within the environment through the following two methods:

* Using the Web UI to manage resources: This method allows users to manage instances, topics, ACLs, and other resources through a web-ui.
* Using Terraform to manage resources: This method requires users to access the AutoMQ BYOC environment via a web browser for the first time to create a Service Account. Subsequently, users can manage resources within the environment using the Service Account's Access Key and the AutoMQ Terraform Provider.

For managing instances, topics, and other resources within the AutoMQ BYOC environment using the AutoMQ Terraform Provider, please refer to the [documentation](https://registry.terraform.io/providers/AutoMQ/automq/latest/docs).

# Module Usage
Use this module to install the AutoMQ BYOC environment, supporting two modes:

* Create a new VPC: Recommended only for POC or other testing scenarios. In this mode, the user only needs to specify the region, and resources including VPC, Endpoint, Security Group, OBS Bucket, etc., will be created. After testing, all resources can be destroyed with one click.
* Using an existing VPC: Recommended for production environments. In this mode, the user needs to provide a VPC, subnet, and OBS Bucket that meet the requirements. AutoMQ will deploy the BYOC environment console to the user-specified subnet.


# Create a new VPC

```terraform
module "automq_byoc" {
  source = "AutoMQ/automq-byoc-environment/huaweicloud"

  # Set the identifier for the environment to be installed. This ID will be used for naming internal resources. The environment ID supports only uppercase and lowercase English letters, numbers, and hyphens (-). It must start with a letter and is limited to a length of 32 characters.
  automq_byoc_env_id                       = "example" 

  # Set the target regionId of huaweicloud
  cloud_provider_region                    = "cn-north-4"

  automq_byoc_env_console_ami_name = "AutoMQ-control-center-Test-0.0.1-SNAPSHOT-2024-09-11-05.53-x86_64"
}

# Necessary outputs
output "automq_byoc_env_id" {
  description = "This parameter is used to create resources within the environment."
  value = module.automq-byoc.automq_byoc_env_id
}

output "automq_byoc_endpoint" {
  description = "Address accessed by AutoMQ BYOC service"
  value = module.automq-byoc.automq_byoc_endpoint
}

output "automq_byoc_initial_username" {
  description = "The initial username for the AutoMQ environment console. It has the `EnvironmentAdmin` role permissions. This account is used to log in to the environment, create ServiceAccounts, and manage other resources. For detailed information about environment members, please refer to the [documentation](https://docs.automq.com/automq-cloud/manage-identities-and-access/member-accounts)."
  value = "admin"
}

output "automq_byoc_initial_password" {
  description = "The initial password for the AutoMQ environment console. This account is used to log in to the environment, create ServiceAccounts, and manage other resources. For detailed information about environment members, please refer to the [documentation](https://docs.automq.com/automq-cloud/manage-identities-and-access/member-accounts)."
  value = module.automq-byoc.automq_byoc_initial_password
}

output "automq_byoc_vpc_id" {
  description = "The VPC ID for the AutoMQ environment deployment."
  value = module.automq-byoc.automq_byoc_vpc_id
}

output "automq_byoc_instance_id" {
  description = "AutoMQ BYOC Console instance ID."
  value = module.automq-byoc.automq_byoc_instance_id
}

```



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0 |
| <a name="requirement_huaweicloud"></a> [huaweicloud](#requirement_huaweicloud) | >= 1.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_huaweicloud"></a> [huaweicloud](#provider_huaweicloud) | >= 1.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [huaweicloud_compute_eip_associate.automq_byoc_eip_associate](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/compute_eip_associate) | resource |
| [huaweicloud_compute_instance.automq_byoc_console](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/compute_instance) | resource |
| [huaweicloud_compute_volume_attach.data_volume_attachment](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/compute_volume_attach) | resource |
| [huaweicloud_dns_zone.private_zone](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/dns_zone) | resource |
| [huaweicloud_evs_volume.data_volume](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/evs_volume) | resource |
| [huaweicloud_identity_agency.automq_byoc_agency](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/identity_agency) | resource |
| [huaweicloud_networking_secgroup.automq_byoc_console_sg](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup) | resource |
| [huaweicloud_networking_secgroup_rule.allow_8080](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/networking_secgroup_rule) | resource |
| [huaweicloud_obs_bucket.automq_byoc_data_bucket](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/obs_bucket) | resource |
| [huaweicloud_obs_bucket.automq_byoc_ops_bucket](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/obs_bucket) | resource |
| [huaweicloud_vpc.automq_byoc_vpc](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc) | resource |
| [huaweicloud_vpc_eip.automq_byoc_eip](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_eip) | resource |
| [huaweicloud_vpc_subnet.private_subnets](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_subnet) | resource |
| [huaweicloud_vpc_subnet.public_subnet](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_subnet) | resource |
| [huaweicloud_availability_zones.zones](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/availability_zones) | data source |
| [huaweicloud_images_image.automq_byoc_console_ami](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/images_image) | data source |
| [huaweicloud_vpc.vpc_info](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/vpc) | data source |
| [huaweicloud_vpc_subnet.public_subnet_info](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/vpc_subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automq_byoc_env_id"></a> [automq_byoc_env_id](#input_automq_byoc_env_id) | The unique identifier of the AutoMQ environment. This parameter is used to create resources within the environment. Additionally, all cloud resource names will incorporate this parameter as part of their names. This parameter supports only numbers, uppercase and lowercase English letters, and hyphens. It must start with a letter and is limited to a length of 32 characters. | `string` | n/a | yes |
| <a name="input_cloud_provider_region"></a> [cloud_provider_region](#input_cloud_provider_region) | Set the cloud provider's region. AutoMQ will deploy to this region. | `string` | n/a | yes |
| <a name="input_create_new_vpc"></a> [create_new_vpc](#input_create_new_vpc) | This setting determines whether to create a new VPC. If set to true, a new VPC spanning three availability zones will be automatically created, which is recommended only for POC scenarios. For production scenario using AutoMQ, you should provide the VPC where the current Kafka application resides and check the current VPC against the requirements specified in the [Prepare VPC Documents](https://docs.automq.com/automq-cloud/getting-started/install-byoc-environment/aws/prepare-vpc). | `bool` | `true` | no |
| <a name="input_automq_byoc_vpc_id"></a> [automq_byoc_vpc_id](#input_automq_byoc_vpc_id) | When the `create_new_vpc` parameter is set to `false`, this parameter needs to be set. Specify an existing VPC where AutoMQ will be deployed. When providing an existing VPC, ensure that the VPC meets [AutoMQ's requirements](https://docs.automq.com/automq-cloud/getting-started/install-byoc-environment/aws/prepare-vpc). | `string` | `""` | no |
| <a name="input_automq_byoc_env_console_public_subnet_id"></a> [automq_byoc_env_console_public_subnet_id](#input_automq_byoc_env_console_public_subnet_id) | When the `create_new_vpc` parameter is set to `false`, this parameter needs to be set. Select a subnet for deploying the AutoMQ BYOC environment console. Ensure that the chosen subnet supports public access. | `string` | `""` | no |
| <a name="input_automq_byoc_env_console_cidr"></a> [automq_byoc_env_console_cidr](#input_automq_byoc_env_console_cidr) | Set CIDR block to restrict the source IP address range for accessing the AutoMQ environment console. If not set, the default is 0.0.0.0/0. | `string` | `"0.0.0.0/0"` | no |
| <a name="input_automq_byoc_data_bucket_name"></a> [automq_byoc_data_bucket_name](#input_automq_byoc_data_bucket_name) | Set the existed OBS bucket used to store message data generated by applications. If this parameter is not set, a new OBS bucket will be automatically created. The message data Bucket must be separate from the Ops Bucket. | `string` | `""` | no |
| <a name="input_automq_byoc_ops_bucket_name"></a> [automq_byoc_ops_bucket_name](#input_automq_byoc_ops_bucket_name) | Set the existed OBS bucket used to store AutoMQ system logs and metrics data for system monitoring and alerts. If this parameter is not set, a new OBS bucket will be automatically created. This Bucket does not contain any application business data. The Ops Bucket must be separate from the message data Bucket. | `string` | `""` | no |
| <a name="input_automq_byoc_ecs_instance_type"></a> [automq_byoc_ecs_instance_type](#input_automq_byoc_ecs_instance_type) | Set the ECS instance type; this parameter is used only for deploying the AutoMQ environment console. You need to provide an ECS instance type with at least 2 cores and 8 GB of memory. | `string` | `"s6.large.2"` | no |
| <a name="input_automq_byoc_env_version"></a> [automq_byoc_env_version](#input_automq_byoc_env_version) | Set the version for the AutoMQ BYOC environment console. It is recommended to keep the default value, which is the latest version. Historical release note reference [document](https://docs.automq.com/automq-cloud/release-notes). | `string` | `"latest"` | no |
| <a name="input_automq_byoc_env_console_ami_name"></a> [automq_byoc_env_console_ami_name](#input_automq_byoc_env_console_ami_name) | When parameter `specified_ami_by_marketplace` set to false, this parameter must set a custom AMI to deploy automq console. | `string` | `""` | no |
| <a name="input_automq_byoc_identity_agency_name"></a> [automq_byoc_identity_agency_name](#input_automq_byoc_identity_agency_name) | Set the agency name for the AutoMQ BYOC environment console. If not set, a new agency will be automatically created. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_automq_byoc_env_id"></a> [automq_byoc_env_id](#output_automq_byoc_env_id) | This parameter is used to create resources within the environment. Additionally, all cloud resource names will incorporate this parameter as part of their names. This parameter supports only numbers, uppercase and lowercase English letters, and hyphens. It must start with a letter and is limited to a length of 32 characters. |
| <a name="output_automq_byoc_endpoint"></a> [automq_byoc_endpoint](#output_automq_byoc_endpoint) | The endpoint for the AutoMQ environment console. Users can set this endpoint to the AutoMQ Terraform Provider to manage resources through Terraform. Additionally, users can access this endpoint via web browser, log in, and manage resources within the environment using the WebUI. |
| <a name="output_automq_byoc_initial_username"></a> [automq_byoc_initial_username](#output_automq_byoc_initial_username) | The initial username for the AutoMQ environment console. It has the `EnvironmentAdmin` role permissions. This account is used to log in to the environment, create ServiceAccounts, and manage other resources. For detailed information about environment members, please refer to the [documentation](https://docs.automq.com/automq-cloud/manage-identities-and-access/member-accounts). |
| <a name="output_automq_byoc_initial_password"></a> [automq_byoc_initial_password](#output_automq_byoc_initial_password) | The initial password for the AutoMQ environment console. This account is used to log in to the environment, create ServiceAccounts, and manage other resources. For detailed information about environment members, please refer to the [documentation](https://docs.automq.com/automq-cloud/manage-identities-and-access/member-accounts). |
| <a name="output_automq_byoc_vpc_id"></a> [automq_byoc_vpc_id](#output_automq_byoc_vpc_id) | The VPC ID for the AutoMQ environment deployment. |
| <a name="output_automq_byoc_instance_id"></a> [automq_byoc_instance_id](#output_automq_byoc_instance_id) | The ECS instance id for AutoMQ Console. |
| <a name="output_automq_byoc_data_bucket_name"></a> [automq_byoc_data_bucket_name](#output_automq_byoc_data_bucket_name) | The object storage bucket used to store message data generated by applications. The message data Bucket must be separate from the Ops Bucket. |
| <a name="output_automq_byoc_ops_bucket_name"></a> [automq_byoc_ops_bucket_name](#output_automq_byoc_ops_bucket_name) | The object storage bucket used to store AutoMQ system logs and metrics data for system monitoring and alerts. This Bucket does not contain any application business data. The Ops Bucket must be separate from the message data Bucket. |
| <a name="output_automq_byoc_env_console_ecs_instance_ip"></a> [automq_byoc_env_console_ecs_instance_ip](#output_automq_byoc_env_console_ecs_instance_ip) | The instance IP of the deployed AutoMQ BYOC control panel. You can access the service through this IP. |
| <a name="output_automq_byoc_env_console_public_subnet_id"></a> [automq_byoc_env_console_public_subnet_id](#output_automq_byoc_env_console_public_subnet_id) | The VPC subnet for the AutoMQ environment deployment. |
| <a name="output_automq_byoc_security_group_name"></a> [automq_byoc_security_group_name](#output_automq_byoc_security_group_name) | Security group bound to the AutoMQ BYOC service. |
| <a name="output_automq_byoc_agency_name"></a> [automq_byoc_agency_name](#output_automq_byoc_agency_name) | AutoMQ BYOC is bound to the agency of the Console. |
| <a name="output_automq_byoc_vpc_dns_zone_id"></a> [automq_byoc_vpc_dns_zone_id](#output_automq_byoc_vpc_dns_zone_id) | DNS Zone bound to the VPC. |
| <a name="output_automq_byoc_env_console_cidr"></a> [automq_byoc_env_console_cidr](#output_automq_byoc_env_console_cidr) | AutoMQ BYOC security group CIDR. |
<!-- END_TF_DOCS -->