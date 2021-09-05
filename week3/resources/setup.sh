#!/bin/bash
cd /Users/khoundokarzahid/Stack/github/FlaskDocker/week3/resources/service_api
docker build --tag service-api .
sleep 2s
cd /Users/khoundokarzahid/Stack/github/FlaskDocker/week3/resources/price_api/
docker build --tag price-api .
sleep 2s
docker volume create my-named-shared-data
sleep 2s
sudo cp -r /Users/khoundokarzahid/Stack/github/FlaskDocker/week3/resources/resources/my-data/* /var/lib/docker/volumes/my-named-shared-data/_data
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
cd ~/environment/
sudo yum groupinstall -y "Development Tools"
sudo yum install -y zlib-devel openssl-devel ncurses-devel libffi-devel sqlite-devel.x86_64 readline-devel.x86_64 bzip2-devel.x86_64
git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
cd /Users/khoundokarzahid/Stack/github/FlaskDocker/week3/resources/
echo 'Complete'
