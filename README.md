# FAST REACT STATIC RENDERER

## Domain
---
### Custom Domain Name
**If you want the application deployed with a custom domain name, you must provide the following optional parameters.**

#### `global-tools/terraform/terraform.tfvars`
`domain_name` - Provide the root/apex domain name to create a Route53 hosted zone.

#### `dev/terraform/terraform.tfvars`
`domain_name` - Root/apex domain name to issue ACM SSL certificate, includes wildcard (`*`) subdomains.

`subdomain_name` - Domain name for CloudFront, will be the primary domain for end users to access the application.

`hosted_zone_id` - Hosted Zone id. Created from `global-tools/terraform/route53-zone.tf` when `global-tools/terraform/terraform.tfvars` -> `domain_name` is set

`catalog_domain_name` - Domain name for CloudFront, used to obtain catalog items.

#### `build-dev/terraform/terraform.tfvars`
`catalog_url` - URL will be provided to [build image](https://github.com/bitovi/fast-react-static-renderer-build-image) at build time to retreive catalog items.

---
### No Custom Domain Name
**The CloudFront default domain name should be used to access the application if the above optional parameters are omitted.**
The default CloudFront domain name can be found in `aws_cloudfront_distribution.cf_distribution_nodom.domain_name` or from the AWS CloudFront Console.