# NXINX Website Resources

This Terraform project manages the workload resources for an NGINX website in the ECS environment

## Resources

This project manages the following resources:

- An ECR repository for the site's Docker images
- An ECS task and service to define and schedule the site's containers
- An Application Load Balancer to direct public HTTP and HTTPS traffic to the ECS service
- an ACM-managed TLS site certificate for the ALB
- A Route53 alias for the site's DNS name

## Variables

Variables are defined in `variables.tf`.

Here are some key variables. Variables with no default value must be defined in the workspace.

| Variable name                   | Description                                    | Default value    |
| ------------------------------- | ---------------------------------------------- | ---------------- |
| aws_resource_prefix             | Prefix for AWS resource names                  | "ecsdemo-"       |
| aws_region_prefix               | Extra prefix for cross-region AWS resources    | ""               |
| aws_ssm_parameter_prefix        | Value of BillingCode tag for resources         | "/ecsdemo"       |
| aws_resource_tag_name           | Name of tag to apply to all resources          | "Project"        |
| aws_resource_tag_value          | Value of tag to apply to all resources         | "ecsdemo"        |
| aws_region                      | AWS region                                     | "ap-southeast-2" |
| nginx_website_dns_name          | Website DNS name (without the domain)          | "nginx"          |
| nginx_repository_suffix         | Suffix for ECR repository name                 | "nginx"          |
| nginx_repository_deploy_tag     | Repository tag for ECR deployments             | "latest"         |
| nginx_service_name              | NGINX ECS service name                         | "nginx"          |
| nginx_service_desired_count     | Desired number of tasks for NGINX service      | 1                |
| nginx_task_family_name          | Name for NGINX ECS tasks                       | "nginx"          |
| nginx_web_container_name        | Name for NGINX task's web container            | "nginx-web"      |
| nginx_web_container_public_port | Container port for NGINX's public interface    | 80               |
| nginx_web_target_group_port     | Target group port for NGINX's public interface | 20001            |
| nginx_web_container_memory      | Minimum memory to launch NGINX Web container   | 128              |
| nginx_alb_idle_timeout          | Timeout for idle ALB requests (seconds)        | 60               |

## First Deployment

You will need to [install the AWS CLI version 2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) if you haven't already.

The first apply of the project should be in offline mode to create the resources without a running workload:

```bash
make apply Vars=offline.tfvars
```

Note the ECR repository URL in the output. The rest of the example steps are for a deployment on AWS account id `999999999999` and region `ap-southeast-2`: change them to match your own deployment.

Start a Docker login session to the ECR repository:

```bash
aws ecr get-login-password | docker login --username AWS --password-stdin 999999999999.dkr.ecr.ap-southeast-2.amazonaws.com
```

Push an intial image to the ECR repository:

```bash
docker image pull nginx:latest
docker image tag nginx:latest 999999999999.dkr.ecr.ap-southeast-2.amazonaws.com/ecsdemo-dev-nginx:latest
docker image push 999999999999.dkr.ecr.ap-southeast-2.amazonaws.com/ecsdemo-dev-nginx:latest
```

Apply the project again to launch the workload:

```bash
make apply
```

End the Docker login session:

```bash
docker logout 999999999999.dkr.ecr.ap-southeast-2.amazonaws.com
```
