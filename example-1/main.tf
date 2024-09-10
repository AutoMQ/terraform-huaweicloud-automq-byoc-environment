module "automq_byoc" {
  source = "../"
  cloud_provider_region = "cn-north-4"
  automq_byoc_env_id = "byoc-test-1"
  automq_byoc_env_console_ami_name = "AutoMQ-control-center-Test-0.0.1-SNAPSHOT-2024-09-10-06.05-x86_64"
  automq_byoc_identity_agency_name = "automq-byoc-agency"
}