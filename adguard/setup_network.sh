#!/bin/bash

# Spin up ipvlan network (not supported in compose)
NETWORK_NAME=adguard-vlan
SUBNET={2:-192.168.1.10/24}
GATEWAY=192.168.1.1
PARENT_INTERFACE={1:-wlan0}

# only create if DNE
if ! docker network ls --format '{{.Name}}' | grep -w "$NETWORK_NAME" > /dev/null; then
	echo "Creating ipvlan network: $NETWORK_NAME"
	docker network create \
		-d ipvlan \
		--subnet="$SUBNET" \ 
		--gateway="$GATEWAY" \
		-o parent="$PARENT_INTERFACE" \
		"$NETWORK_NAME"
else
	echo "Network '$NETWORK_NAME' already exists"
fi
