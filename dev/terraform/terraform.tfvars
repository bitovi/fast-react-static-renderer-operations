# REQUIRED PARAMITERS
bucket_name = "fast-react-static-renderer-sites-dev"

# OPTIONAL PARAMITERS
common_tags = {
    terraform                 = "true"
    OperationsRepo            = "bitovi/fast-react-static-renderer-operations"
    OperationsRepoEnvironment = "global-tools"
}

# Domains
# domain_name = "fast-react-static-renderer.com"
# subdomain_name = "dev.fast-react-static-renderer.com"
# Hosted Zone (configured in global-tools/terraform/route53-zone.tf)
# hosted_zone_id = "Z09768261LFU7OL6902KA"