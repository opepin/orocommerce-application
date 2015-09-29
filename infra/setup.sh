#!/bin/bash 
mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" < infra/createdb.sql

php app/console oro:install --application-url $ORO_APPLICATION_URL --env $ORO_ENV --organization-name $ORO_ORG --user-name $ORO_ADMIN_NAME --user-email $ORO_ADMIN_EMAIL --user-firstname $ORO_ADMIN_FIRST --user-lastname $ORO_ADMIN_LAST --user-password $ORO_ADMIN_PW --no-interaction

# Fixing some permissions
mkdir -p app/cache 
mkdir -p app/logs
setfacl -dR -m u::rwX app/cache app/logs
chmod -R 777 app/cache
chmod -R 777 app/cache

apache2 -X 
