#Purpose: Stop all instances during off-hours and start them during work hours.

#!/bin/bash

source ~/openstack_credentials.sh
hour=$(date +%H)

if [[ $hour -ge 22 || $hour -lt 6 ]]; then
  echo "Stopping all instances..."
  openstack server list --status ACTIVE -f value -c ID | while read instance; do
    openstack server stop $instance
  done
else
  echo "Starting all instances..."
  openstack server list --status SHUTOFF -f value -c ID | while read instance; do
    openstack server start $instance
  done
fi
