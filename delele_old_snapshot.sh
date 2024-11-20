#Purpose: Remove snapshots older than 7 days to save space.

#!/bin/bash

source ~/openstack_credentials.sh
echo "Deleting snapshots older than 7 days..."
openstack image list --status active -f value -c ID -c Name | while read id name; do
  creation_date=$(openstack image show $id -f value -c created_at)
  if [[ $(date -d "$creation_date" +%s) -lt $(date -d '7 days ago' +%s) ]]; then
    echo "Deleting snapshot: $name"
    openstack image delete $id
  fi
done
