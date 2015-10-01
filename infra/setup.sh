#!/bin/bash 

php app/console oro:install --application-url $ORO_APPLICATION_URL --env $ORO_ENV --organization-name $ORO_ORG --user-name $ORO_ADMIN_NAME --user-email $ORO_ADMIN_EMAIL --user-firstname $ORO_ADMIN_FIRST --user-lastname $ORO_ADMIN_LAST --user-password $ORO_ADMIN_PW --no-interaction --drop-database

# Fixing some permissions
chown -R root:www-data /opt/oro 
chmod u+rwx,g+rx,o+rx /opt/oro 
find /opt/oro -type d -exec chmod u+rwx,g+rwx,o+rx {} + 
find /opt/oro -type f -exec chmod u+rw,g+rw,o+r {} +

chown -R www-data:www-data /opt/oro/app/cache 
chown -R www-data:www-data /opt/oro/app/logs 
apache2 -X 
