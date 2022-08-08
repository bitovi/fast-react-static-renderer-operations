#!/bin/bash

echo "import already performed - can now remove this file"
exit 0

BUCKET="fast-react-static-renderer-artifacts"
echo "Taking ownership of bucket: $BUCKET"

cd $TERRAFORM_ROOT
terraform-0.13.2 init
terraform-0.13.2 import aws_s3_bucket.s3_static_files $BUCKET
cd -
echo "exiting"
exit 1