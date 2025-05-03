ANSIBLE_DIR=ansible
ANSIBLE_CFG=ansible/ansible.cfg
INVENTORY=$(ANSIBLE_DIR)/inventory.yml
MAIN_PLAYBOOK=$(ANSIBLE_DIR)/main.yml
SERVICES_PLAYBOOK=$(ANSIBLE_DIR)/playbooks/docker-services.yml

PYTHON_ENV=.venv/bin
ANSIBLE=$(PYTHON_ENV)/ansible-playbook

export ANSIBLE_CONFIG=$(ANSIBLE_CFG)

.PHONY: deploy caddy homepage

deploy:
	$(ANSIBLE) $(MAIN_PLAYBOOK)

caddy:
	$(ANSIBLE) -i $(INVENTORY) $(SERVICES_PLAYBOOK) --tags caddy_config

homepage:
	$(ANSIBLE) -i $(INVENTORY) $(SERVICE_PLAYBOOK) --tags homepage_config
