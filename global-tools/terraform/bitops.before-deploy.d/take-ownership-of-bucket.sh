#!/bin/bash

BUCKET="fast-react-static-renderer-artifacts"
echo "Taking ownership of bucket: $BUCKET"

terraform-0.13.2 import aws_s3_bucket.s3_static_files $BUCKET