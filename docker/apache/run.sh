#!/bin/bash
set -xe

# Configure the basic authentication if needed
if [ ! -z "$HTTP_BASIC_USERNAME" ]; then
	htpasswd -cb /etc/apache2/users $HTTP_BASIC_USERNAME $HTTP_BASIC_PASSWORD
	sed -i 's/#AUTH: / /g' /etc/apache2/sites-available/000-default.conf
fi

# Start Apache with the right permissions
/app/docker/apache/start_safe_perms -DFOREGROUND
