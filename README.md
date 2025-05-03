# Homelab

## Core Services

- Caddy for reverse proxy
- Adguard Home for DNS rewrites + DNS sinkhole
- Vaultwarden for password manager
- wg-easy for VPN

## Ansible

Using ansible to manage our configuration, with galaxy to manage external roles.
Run `ansible-galaxy install -r requirements.yml -p roles/galaxy` from ./ansible/

### Design Notes

I took a modular approach to the ansible config to help with future extensibility. One goal of mine is to upgrade my equipment, so I chose to define a separate role for each service to help when I split into multiple machines.


### Startup

- Toggle create user in vw on
- Toggle port 3000 for adguard, and make sure it's allowed through firewall
    - Use that to get initial connection and config
    - Make sure to configure web ui to listen to port 3000, and add dns rewrites for each service (or add *.home) 
