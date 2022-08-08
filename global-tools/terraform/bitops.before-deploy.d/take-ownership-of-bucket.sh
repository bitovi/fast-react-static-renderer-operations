#!/bin/bash

BUCKET="fast-react-static-renderer-artifacts"
echo "Taking ownership of bucket: $BUCKET"

terraform import aws_s3_bucket.s3_static_files $BUCKET