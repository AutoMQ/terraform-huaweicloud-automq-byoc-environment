variable "automq_byoc_env_id" {
  description = "The unique identifier of the AutoMQ environment. This parameter is used to create resources within the environment. Additionally, all cloud resource names will incorporate this parameter as part of their names. This parameter supports only numbers, uppercase and lowercase English letters, and hyphens. It must start with a letter and is limited to a length of 32 characters."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{0,31}$", var.automq_byoc_env_id)) && !can(regex("_", var.automq_byoc_env_id))
    error_message = "The environment_id must start with a letter, can only contain alphanumeric characters and hyphens, cannot contain underscores, and must be 32 characters or fewer."
  }
}

variable "cloud_provider_region" {
  description = "Set the cloud provider's region. AutoMQ will deploy to this region."
  type        = string
}

variable "create_new_vpc" {
  description = "This setting determines whether to create a new VPC. If set to true, a new VPC spanning three availability zones will be automatically created, which is recommended only for POC scenarios."
  type        = bool
  default     = true
}

variable "automq_byoc_vpc_id" {
  description = "When the `create_new_vpc` parameter is set to `false`, this parameter needs to be set. Specify an existing VPC where AutoMQ will be deployed."
  type        = string
  default     = ""
}

variable "automq_byoc_env_console_public_subnet_id" {
  description = "When the `create_new_vpc` parameter is set to `false`, this parameter needs to be set. Select a subnet for deploying the AutoMQ BYOC environment console. Ensure that the chosen subnet supports public access."
  type        = string
  default     = ""
}

variable "automq_byoc_env_console_cidr" {
  description = "Set CIDR block to restrict the source IP address range for accessing the AutoMQ environment console. If not set, the default is 0.0.0.0/0."
  type        = string
  default     = "0.0.0.0/0"
}

variable "automq_byoc_data_bucket_name" {
  description = "Set the existed OBS bucket used to store message data generated by applications. If this parameter is not set, a new OBS bucket will be automatically created. The message data Bucket must be separate from the Ops Bucket."
  type        = string
  default     = ""
}

variable "automq_byoc_ops_bucket_name" {
  description = "Set the existed OBS bucket used to store AutoMQ system logs and metrics data for system monitoring and alerts. If this parameter is not set, a new OBS bucket will be automatically created. This Bucket does not contain any application business data. The Ops Bucket must be separate from the message data Bucket."
  type        = string
  default     = ""
}

variable "automq_byoc_ecs_instance_type" {
  description = "Set the ECS instance type; this parameter is used only for deploying the AutoMQ environment console. You need to provide an ECS instance type with at least 2 cores and 8 GB of memory."
  type        = string
  default     = "s6.large.2"
}

variable "automq_byoc_env_version" {
  description = "Set the version for the AutoMQ BYOC environment console. It is recommended to keep the default value, which is the latest version. Historical release note reference [document](https://docs.automq.com/automq-cloud/release-notes)."
  type        = string
  default     = "1.4.0-rc"
}

variable "use_custom_ami" {
  description = "The parameter defaults to false, which means a specific AMI is not specified. If you wish to use a custom AMI, set this parameter to true and specify the `automq_byoc_env_console_ami` parameter with your custom AMI ID."
  type        = bool
  default     = false
}

variable "automq_byoc_env_console_ami" {
  description = "When the `use_custom_ami` parameter is set to true, this parameter must be set with a custom AMI Name to deploy the AutoMQ console."
  type        = string
  default     = ""
}

variable "automq_byoc_default_deploy_type" {
  description = "Set the default deployment type for the AutoMQ BYOC environment. The default value is vm. The supported values are vm and k8s."
  type        = string
  default     = "vm"
}