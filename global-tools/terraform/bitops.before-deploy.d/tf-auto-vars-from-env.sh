#!/bin/bash

if [ -n "$TFVARS_AUTO_JSON" ]; then
  echo "Creating TF Auto vars from env var (TFVARS_AUTO_JSON): $TFVARS_AUTO_JSON"
  AUTO_VARS_FILE="$TERRAFORM_ROOT/vars.auto.tfvars.json"
  echo $TFVARS_AUTO_JSON > $AUTO_VARS_FILE

  echo "File contents for $AUTO_VARS_FILE"
  cat $AUTO_VARS_FILE
fi