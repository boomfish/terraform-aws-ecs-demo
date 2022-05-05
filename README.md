# Terraform ECS Demonstration 

This repository contains Terraform projects to manage AWS resources for an ECS environment with an NGINX workload.

## Features

- Uses Terraform 1.0 syntax and follows recommended practices
- Supports deployment to multiple AWS environments
- Terraform runtime isolation: upgrading Terraform version won't impact other projects
- Can be deployed from native Windows (WSL not required)

## Standard Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop) or [Docker Engine](https://docs.docker.com/engine/)
- [Docker Compose](https://docs.docker.com/compose/) (tested with version 1, but version 2 should work as well)
- [GNU Make](https://www.gnu.org/software/make/)
- A Bourne-compatible shell such as [bash](https://www.gnu.org/software/bash/), [zsh](https://www.zsh.org
), or [busybox](https://busybox.net)

GNU Make and bash are installed by default in Linux distributions.

MacOS has either bash or zsh installed by default. To install GNU Make in MacOS using [Homebrew](https://brew.sh):

```bash
brew install make
```

To install GNU Make and Busybox in Windows using [Scoop](https://scoop.sh):

```bash
scoop install make
scoop install busybox
```

To install GNU Make and Busybox using [Chocolatey](https://chocolatey.org):

```bash
choco install -y make
choco install -y busybox
```

### Using asdf instead of Docker to run Terraform

A local install of Terraform can used instead of Docker containers for Terraform runs but due to version dependencies this is not recommended unless the user is using a compatible tool version manager.

This repository includes support for the [asdf](http://asdf-vm.com/) tool version manager, so Linux and MacOS users can use asdf instead of Docker to launch the correct version of Terraform.

In addition to asdf this option requires installation of the following plugins:

- [asdf-hashicorp](https://github.com/asdf-community/asdf-hashicorp) (install for terraform)
- [asdf-direnv])(https://github.com/asdf-community/asdf-direnv)

To use this option for a Terraform project in this respository, create a `.envrc` file in the project folder with the following contents:

```bash
export LocalTerraform=1
```

Then run the following command from the project folder:

```bash
direnv allow .
```

To disable, delete the entry in the `.envrc` file and/or run `direnv deny .` in the project folder.

# Projects and Workspaces

There are a number of project folders in this repository that need to be deployed to create a full ECS environment and workload under AWS:

- `aws/base`: AWS base resources such as VPC and DNS
- `aws/cluster`: AWS server resources such as EC2 workers and the ECS cluster
- `aws/workloads/nginx`: AWS Web workload resources such as ECS Tasks, Application Load Balancers, and TLS Certificates

The following environment definitions have been provided:

- `dev`: Low-capacity workload in the default region
- `prod`: Production-capacity workload in the default region
- `prod2`: Production-capacity workload in the `us-west-2` (Oregon) region

To deploy an environment definition, setup a workspace with the same name in each project and deploy them in sequence. For example, to deploy a dev environment:

1. Setup and deploy a `dev` workspace in `aws/base`
2. Setup and deploy a `dev` workspace in `aws/cluster`
3. Setup and deploy a `dev` workspace in `aws/workloads/nginx`

The `env` subdirectory contains Terraform variables files for workspaces. If `make` is used to select a workspace and the corresponding tfvars file exists, its contents is copied to `env.auto.tfvars` to be used automatically in plans.


# Basic Project Workflow

To prepare a project after checkout:

```bash
make init
```

To create a new workspace with the name `dev`:

```bash
make mkws Name=dev
```

To change the active workspace and copy in its env variables, use the workspace name as the make target:

```bash
make prod
```

To check the project for syntax errors:

```bash
make validate
```

To perform a dry-run of a deployment:

```bash
make plan
```

To deploy:

```bash
make apply
```

To clean up:

```bash
make clean
```

For more options, run `make` or `make help`.

## TODO

- EC2 autoscaling group and ECS capacity provider
- CodePipeline for continous deployment
- Split EC2+Fargate capacity provider strategy?

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

## Contact

Dennis Clark - [@boomerangfish](https://twitter.com/boomerangfish) - boomfish@gmail.com

Project Link: [https://github.com/boomfish/terraform-ecs-demo](https://github.com/boomfish/terraform-ecs-demo)
