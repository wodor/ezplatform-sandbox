#!/bin/sh
set -xe

# Update parameters from environment variables
composer run-script update-parameters

if [ ! -f .skip-fix-permissions ]; then

  # Fixes permissions again
  /app/docker/build/fix-permissions.sh

  # Run Apache
  /app/docker/apache/run.sh
else
  # Skip fixing permissions
  apache2 -DFOREGROUND
fi

