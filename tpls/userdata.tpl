#cloud-config
bootcmd:
  - |
    if [ ! -f "/opt/cmp/config.properties" ]; then
      touch /opt/cmp/config.properties
      echo "cmp.provider.credential=vm-role://${huaweicloud_iam_agency_name}@huaweicloud" >> /opt/cmp/config.properties
      echo 'cmp.provider.databucket=${automq_data_bucket}' >> /opt/cmp/config.properties
      echo 'cmp.provider.opsBucket=${automq_ops_bucket}' >> /opt/cmp/config.properties
      echo 'cmp.provider.scope=${huaweicloud_account_id}' >> /opt/cmp/config.properties
      echo 'cmp.provider.instanceSecurityGroup=${instance_security_group_id}' >> /opt/cmp/config.properties
      echo 'cmp.provider.instanceDNS=${instance_dns}' >> /opt/cmp/config.properties
      echo 'cmp.provider.instanceProfile=${huaweicloud_iam_agency_name}' >> /opt/cmp/config.properties
      echo 'cmp.environmentId=${environment_id}' >> /opt/cmp/config.properties
      echo 'cmp.provider.deployType=${deploy_type}' >> /opt/cmp/config.properties
    fi