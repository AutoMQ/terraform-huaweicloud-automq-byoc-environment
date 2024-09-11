provider "huaweicloud" {
  region = var.cloud_provider_region
}

# OBS buckets for data and ops
resource "huaweicloud_obs_bucket" "automq_byoc_data_bucket" {
  count         = var.automq_byoc_data_bucket_name == "" ? 1 : 0
  bucket        = "automq-data-${var.automq_byoc_env_id}"
  storage_class = "STANDARD"
  acl           = "private"
  force_destroy = true

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }
}

resource "huaweicloud_obs_bucket" "automq_byoc_ops_bucket" {
  count         = var.automq_byoc_ops_bucket_name == "" ? 1 : 0
  bucket        = "automq-ops-${var.automq_byoc_env_id}"
  storage_class = "STANDARD"
  acl           = "private"
  force_destroy = true

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }
}

data "huaweicloud_availability_zones" "zones" {}

# VPC and Subnets
resource "huaweicloud_vpc" "automq_byoc_vpc" {
  count = var.create_new_vpc ? 1 : 0
  name  = "automq-byoc-vpc-${var.automq_byoc_env_id}"
  cidr  = "10.0.0.0/16"

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }
}

resource "huaweicloud_vpc_subnet" "public_subnet" {
  count      = var.create_new_vpc ? 1 : 0
  name       = "automq-byoc-public-subnet-${var.automq_byoc_env_id}"
  cidr       = "10.0.0.0/20"
  gateway_ip = cidrhost("10.0.0.0/20", 1)
  vpc_id     = huaweicloud_vpc.automq_byoc_vpc[0].id
}

resource "huaweicloud_vpc_subnet" "private_subnets" {
  count      = var.create_new_vpc ? 3 : 0
  name       = "automq-byoc-private-subnet-${var.automq_byoc_env_id}-${count.index}"
  cidr       = "10.0.${128 + count.index * 16}.0/20"
  gateway_ip = cidrhost("10.0.${128 + count.index * 16}.0/20", 1)
  vpc_id     = huaweicloud_vpc.automq_byoc_vpc[0].id
}

# Security Group
resource "huaweicloud_networking_secgroup" "automq_byoc_console_sg" {
  name        = "automq-byoc-console-sg-${var.automq_byoc_env_id}"
  description = "Security group for AutoMQ BYOC console"

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }
}

resource "huaweicloud_networking_secgroup_rule" "allow_8080" {
  security_group_id = huaweicloud_networking_secgroup.automq_byoc_console_sg.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = var.automq_byoc_env_console_cidr
}

resource "huaweicloud_identity_agency" "automq_byoc_agency" {
  count                  = var.automq_byoc_identity_agency_name == "" ? 1 : 0
  name                   = "automq-byoc-agency-${var.automq_byoc_env_id}"
  description            = "Agency for AutoMQ BYOC"
  delegated_service_name = "op_svc_ecs"

  all_resources_roles = ["ECS FullAccess", "OBS Administrator", "DNS FullAccess", "AutoScaling FullAccess", "IMS FullAccess", "VPC FullAccess"]
}

# DNS Zone 
resource "huaweicloud_dns_zone" "private_zone" {
  name        = "${var.automq_byoc_env_id}.automq.private."
  description = "Private zone for AutoMQ BYOC"
  zone_type   = "private"

  router {
    router_id = var.create_new_vpc ? huaweicloud_vpc.automq_byoc_vpc[0].id : var.automq_byoc_vpc_id
  }

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }
}

# Locals
locals {
  automq_byoc_vpc_id                       = var.create_new_vpc ? huaweicloud_vpc.automq_byoc_vpc[0].id : var.automq_byoc_vpc_id
  automq_byoc_env_console_public_subnet_id = var.create_new_vpc ? huaweicloud_vpc_subnet.public_subnet[0].id : var.automq_byoc_env_console_public_subnet_id
  automq_data_bucket                       = var.automq_byoc_data_bucket_name == "" ? huaweicloud_obs_bucket.automq_byoc_data_bucket[0].bucket : var.automq_byoc_data_bucket_name
  automq_ops_bucket                        = var.automq_byoc_ops_bucket_name == "" ? huaweicloud_obs_bucket.automq_byoc_ops_bucket[0].bucket : var.automq_byoc_ops_bucket_name
  agency_name                              = var.automq_byoc_identity_agency_name == "" ? huaweicloud_identity_agency.automq_byoc_agency[0].name : var.automq_byoc_identity_agency_name
}

# Data sources
data "huaweicloud_vpc" "vpc_info" {
  id = local.automq_byoc_vpc_id
}

data "huaweicloud_vpc_subnet" "public_subnet_info" {
  id = local.automq_byoc_env_console_public_subnet_id
}

data "huaweicloud_images_image" "automq_byoc_console_ami" {
  name        = var.automq_byoc_env_console_ami_name
  most_recent = true
}
