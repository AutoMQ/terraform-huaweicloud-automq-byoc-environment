resource "huaweicloud_compute_instance" "automq_byoc_console" {
  name               = "automq-byoc-console-${var.automq_byoc_env_id}"
  image_id           = data.huaweicloud_images_image.automq_byoc_console_ami.id
  flavor_id          = var.automq_byoc_ecs_instance_type
  availability_zone  = data.huaweicloud_availability_zones.zones.names[0]
  security_group_ids = [huaweicloud_networking_secgroup.automq_byoc_console_sg.id]
  network {
    uuid = local.automq_byoc_env_console_public_subnet_id
  }

  system_disk_type = "SSD"
  system_disk_size = 20

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }

  agency_name = huaweicloud_identity_agency.automq_byoc_agency.name

  user_data = base64encode(templatefile("${path.module}/tpls/userdata.tpl", {
    huaweicloud_iam_agency_name = huaweicloud_identity_agency.automq_byoc_agency.name
    automq_data_bucket          = local.automq_data_bucket,
    automq_ops_bucket           = local.automq_ops_bucket,
    instance_security_group_id  = huaweicloud_networking_secgroup.automq_byoc_console_sg.id,
    instance_dns                = huaweicloud_dns_zone.private_zone.id,
    environment_id              = var.automq_byoc_env_id,
    huaweicloud_account_id      = data.huaweicloud_account.current.id,
    deploy_type                 = var.automq_byoc_default_deploy_type,
  }))
}

resource "huaweicloud_compute_eip_associate" "automq_byoc_eip_associate" {
  public_ip   = huaweicloud_vpc_eip.automq_byoc_eip.address
  instance_id = huaweicloud_compute_instance.automq_byoc_console.id
}

resource "huaweicloud_vpc_eip" "automq_byoc_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "automq-byoc-eip-${var.automq_byoc_env_id}"
    size        = 8
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_evs_volume" "data_volume" {
  name              = "automq-byoc-data-volume-${var.automq_byoc_env_id}"
  availability_zone = data.huaweicloud_availability_zones.zones.names[0]
  volume_type       = "SSD"
  size              = 20

  tags = {
    automqVendor        = "automq"
    automqEnvironmentID = var.automq_byoc_env_id
  }
}

resource "huaweicloud_compute_volume_attach" "data_volume_attachment" {
  instance_id = huaweicloud_compute_instance.automq_byoc_console.id
  volume_id   = huaweicloud_evs_volume.data_volume.id
}
