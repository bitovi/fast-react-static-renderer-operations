#!/bin/bash

echo "Creating TF Auto vars from env var (TFVARS_AUTO_JSON): $TFVARS_AUTO_JSON"
echo $TFVARS_AUTO_JSON > $TERRAFORM_ROOT/vars.auto.tfvars.json