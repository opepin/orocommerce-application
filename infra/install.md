# QUICK START WITH DOCKER

## Install docker and docker compose (Mac)
sudo gem install thor
brew install https://github.com/codekitchen/dinghy/raw/latest/dinghy.rb
curl -L https://github.com/docker/compose/releases/download/1.3.3/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

## Install oro-commerce
git clone --recursive https://github.com/orocrm/orocommerce-application.git

## bootstrap environement (config in docker-compose.yml)
docker-compose up -d webdev

## open 
open http://orocommerce.docker/admin/
open http://orocommerce.docker/

