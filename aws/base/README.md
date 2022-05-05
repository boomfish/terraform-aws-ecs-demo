# AWS base

This Terraform project manages the base resources for an ECS environment

## Resources

This project manages the following resources:

- A Route53 zone for the domain
- A VPC with public and private subnets and a single NAT gateway
- A VPC flow log to an S3 bucket (optional)
- Standard VPC security groups for use in child projects
- SSM Parameter Store parameters to identify resources to child projects

## Variables

Variables are declared in `variables.tf`.

Here are some key variables. Variables with no default value must be defined in the workspace.

| Variable name              | Description                                  | Default value          |
| -------------------------- | -------------------------------------------- | ---------------------- |
| aws_resource_prefix        | Prefix for AWS resource names                | "ecsdemo-"             |
| aws_region_prefix          | Extra prefix for cross-region AWS resources  | ""                     |
| aws_ssm_parameter_prefix   | Value of BillingCode tag for resources       | "/ecsdemo"             |
| aws_resource_tag_name      | Name of tag to apply to all resources        | "Project"              |
| aws_resource_tag_value     | Value of tag to apply to all resources       | "ecsdemo"              |
| aws_region                 | AWS region                                   | "ap-southeast-2"       |
| aws_az_names               | Availability zones to use | ["ap-southeast-2a","ap-southeast-2b","ap-southeast-2c"] |
| route53_domain_name        | S3 bucket destination for VPC flow logs      | "ecsdemo.boomfish.net" |
| vpc_net_address            | Network address of VPC                       | "10.51.0.0"            |
| vpc_flowlog_enabled        | Enable Flow Log for the VPC?                 | false                  |
| vpc_flowlog_s3_bucket_name | S3 bucket to send VPC flow logs              | ""                     |

## Outputs

Output values are declared in `outputs.tf`.

| Output name                 | Description                                                    |
| --------------------------- | -------------------------------------------------------------- |
| route53_domain_name_servers | List of name servers to use for the domain's parent NS record  |

## First Deployment

Apply the project:

```bash
make apply
```

Note the `route53_domain_name_servers` in the output.

If this is a registered domain, go to your DNS registrar's management interface and set the name servers for the domain.

If this is a subdomain, go to the DNS record management interface for the parent domain and create a `NS` record for the subdomain with the name servers as individual values.

## Multi-region Production

The default for the `prod2` environment uses the same domain name as the `prod` environment. If you wish you can have both environments share the same DNS zone.

Reasons to do this:

- Run different workloads in different regions
- Deploy a recovery copy of a workload in an alternate region if the primary region has an outage

Note that if you try to deploy 2 workloads with the same DNS name in both `prod` and `prod2` when they share a DNS zone, DNS will go to the workload from the most recent apply.

### Setup

Switch to the `prod` workspace:

```bash
make prod
```

Apply the project:

```bash
make apply
```

Note the zone ID in the output.

Switch to the `prod2` workspace:

```bash
make prod2
```

Import the prod Route53 zone into the workspace (change 'Z1D633PJN98FT9' to match your own zone ID):

```bash
make terraform Args='import aws_route53_zone.domain Z1D633PJN98FT9'
```

Apply the `prod2` workspace:

```bash
make apply
```
