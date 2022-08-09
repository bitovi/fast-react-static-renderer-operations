# FAST REACT STATIC RENDERER

## Domain
---
### Custom Domain Name
**If you want the application deployed with a custom domain name, you must provide the following optional parameters.**

> In an effort to keep the terraform clean and reusable, the domain-specific logic that powers the `fast-react-static-renderer.com` (which is driven from this repo) has been moved to the pipelines.  The GitHub Actions pipelins specify an environment variable called `TFVARS_AUTO_JSON` which is then converted to a `vars.auto.tfvars.json` file by a BitOps before script.
> 
> If you fork this repo, you'll need to take care in your pipelines to ensure you are working with domains as you'd expect.

#### `global-tools/terraform/terraform.tfvars`
`domain_name` - Provide the root/apex domain name to create a Route53 hosted zone.

#### `dev/terraform/terraform.tfvars`
`domain_name` - Root/apex domain name to issue ACM SSL certificate, includes wildcard (`*`) subdomains.

`subdomain_name` - Domain name for CloudFront, will be the primary domain for end users to access the application.

`hosted_zone_id` - Hosted Zone id. Created from `global-tools/terraform/route53-zone.tf` when `global-tools/terraform/terraform.tfvars` -> `domain_name` is set

---
### No Custom Domain Name
**The CloudFront default domain name should be used to access the application if the above optional parameters are omitted.**
The default CloudFront domain name can be found in `aws_cloudfront_distribution.cf_distribution_nodom.domain_name` or from the AWS CloudFront Console.