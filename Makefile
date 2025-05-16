MODE ?= remote
ifeq ($(MODE),local)
	INVENTORY = localhost
	CONNECTION = -c local
else
	INVENTORY=$(ANSIBLE_DIR)/inventory.yml
	CONNECTION = 
endif

ANSIBLE_DIR=ansible
ANSIBLE_CFG=ansible/ansible.cfg
MAIN_PLAYBOOK=$(ANSIBLE_DIR)/main.yml
MONITORING_PLAYBOOK=$(ANSIBLE_DIR)/playbooks/monitoring.yml
SERVICES_PLAYBOOK=$(ANSIBLE_DIR)/playbooks/docker-services.yml

PYTHON_ENV=.venv/bin
ANSIBLE=$(PYTHON_ENV)/ansible-playbook

export ANSIBLE_CONFIG=$(ANSIBLE_CFG)

.PHONY: deploy caddy homepage monitoring

deploy:
	$(ANSIBLE) -i $(INVENTORY) $(CONNECTION) $(MAIN_PLAYBOOK)

caddy:
	$(ANSIBLE) -i $(INVENTORY) $(SERVICES_PLAYBOOK) --tags caddy_config

homepage:
	$(ANSIBLE) -i $(INVENTORY) $(SERVICE_PLAYBOOK) --tags homepage_config

monitoring:
	$(ANSIBLE) $(MONITORING_PLAYBOOK)
