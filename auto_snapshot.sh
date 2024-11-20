#Purpose: Create snapshots for all running instances.

#!/bin/bash

source ~/openstack_credentials.sh
instances=$(openstack server list --status ACTIVE -f value -c ID)

for instance in $instances; do
  timestamp=$(date +%Y%m%d%H%M%S)
  snapshot_name="${instance}_snapshot_$timestamp"
  echo "Creating snapshot for instance $instance..."
  openstack server image create --name $snapshot_name $instance
done
