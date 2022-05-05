# Terraform.mk

# Defaults

ifndef DOCKER_COMPOSE
DOCKER_COMPOSE=docker-compose
endif

# Names of all supported workspaces (must not clash with any other target names)
ifndef WORKSPACES
WORKSPACES=default
endif

# If this variable is set, run locally installed Terraform instead of a Terraform Docker container
ifdef LocalTerraform
TERRAFORM=terraform
else
TERRAFORM=$(DOCKER_COMPOSE) run --rm terraform
endif

# plan/apply/destroy arguments

ifdef Target
TARGETARGS=-target=$(Target)
else
TARGETARGS=
endif

ifdef Replace
REPLACEARGS=-replace=$(Replace)
else
REPLACEARGS=
endif

ifdef Vars
VARSARGS=-var-file=$(Vars)
else
VARSARGS=
endif

## Targets

help:
	@echo "General targets:" >&2
	@echo "  init      Initialise local Terraform workspaces" >&2
	@echo "  upgrade   Upgrade the installed Terraform modules" >&2
	@echo "  validate  Check the Terraform configuration" >&2
	@echo "  pws       Print the current workspace name" >&2
	@echo "  lws       List the available and supported workspaces" >&2
	@echo "  mkws Name=\"...\"" >&2
	@echo "            Create a new workspace with the given name" >&2
	@echo "  $(WORKSPACES)" >&2
	@echo "            Select the workspace" >&2
	@echo "  show      Show the current workspace state" >&2
	@echo "  terraform Args=\"...\"" >&2
	@echo "            Run terraform with supplied arguments" >&2
	@echo "  clean     Clean up any local resources used by Terraform runs" >&2
	@echo "" >&2
	@echo "Plan targets:" >&2
	@echo "  plan [Target=...] [Vars=...] [Replace=...]" >&2
	@echo "            Display changes required to bring environment up-to-date with workspace" >&2
	@echo "  plan-refresh [Target=...] [Vars=...] [Replace=...]" >&2
	@echo "            Display changes in the environment that do not appear in the workspace state" >&2
	@echo "  plan-destroy [Target=...] [Vars=...]" >&2
	@echo "            Display a plan to delete remote objects" >&2
	@echo "" >&2
	@echo "Update targets:" >&2
	@echo "  apply [Target=...] [Vars=...] [Replace=...]" >&2
	@echo "            Perform changes to the environment to bring it up-to-date with the workspace" >&2
	@echo "  apply-refresh [Target=...] [Vars=...] [Replace=...]" >&2
	@echo "            Refresh the workspace state to include changes in the environment" >&2
	@echo "  destroy [Target=...] [Vars=...]" >&2
	@echo "            Trigger the deletion of remote objects" >&2
	@echo "" >&2
	@echo "Plan/Update arguments:" >&2
	@echo "  Target=\"object\"" >&2
	@echo "            Limit plan/apply/destroy to specified object" >&2
	@echo "  Vars=\"file.tfvars\"" >&2
	@echo "            Read variable values from file to override default values in the project" >&2
	@echo "  Replace=\"object\"" >&2
	@echo "            Include replacement of the specified object in the plan" >&2

init validate show:
	$(TERRAFORM) $@

upgrade:
	$(TERRAFORM) init --upgrade

pws:
	$(TERRAFORM) workspace show

lws:
	@echo "Supported workspaces:"
	@echo "$(WORKSPACES)"
	@echo "Available workspaces:"
	$(TERRAFORM) workspace list

mkws:
ifndef Name
	$(error Name is undefined)
endif
	$(TERRAFORM) workspace new $(Name)
	[ ! -f env/$(Name).tfvars ] || cp env/$(Name).tfvars env.auto.tfvars

.PHONY:	$(WORKSPACES)

$(WORKSPACES):
	$(TERRAFORM) workspace select $@
	[ ! -f env/$@.tfvars ] || cp env/$@.tfvars env.auto.tfvars

plan apply:
	$(TERRAFORM) $@ $(TARGETARGS) $(VARSARGS) $(REPLACEARGS)

plan-refresh:
	$(TERRAFORM) plan -refresh-only $(TARGETARGS) $(VARSARGS) $(REPLACEARGS)

apply-refresh:
	$(TERRAFORM) apply -refresh-only $(TARGETARGS) $(VARSARGS) $(REPLACEARGS)

plan-destroy:
	$(TERRAFORM) plan -destroy $(TARGETARGS) $(VARSARGS)

destroy:
	$(TERRAFORM) destroy $(TARGETARGS) $(VARSARGS)

terraform:
ifndef Args
	$(error Args is undefined)
endif
	$(TERRAFORM) $(Args)

down:
ifndef LocalTerraform
	$(DOCKER_COMPOSE) down
endif

clean:	down
ifndef LocalTerraform
	rm -rf .terraform.d
else
	@echo "Local terraform leaves no resources within the project that are safe to clean."
endif
	@[ ! -d .terraform ] || echo "The .terraform directory may include remote state information and will not be removed automatically."
