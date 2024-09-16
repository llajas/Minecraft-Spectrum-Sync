#!/bin/bash

terraform plan -detailed-exitcode -out=tfplan

if [ $? -eq 2 ]; then
  terraform apply -auto-approve tfplan
elif [ $? -eq 0 ]; then
  echo "No changes detected."
else
  echo "Error during terraform plan."
  exit 1
fi
