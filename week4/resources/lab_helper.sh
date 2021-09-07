#!/bin/bash

sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
sudo chmod +x /usr/local/bin/ecs-cli
sleep 2

cd /Users/khoundokarzahid/Stack/github/FlaskDocker/week4/resources/service_api
docker build --tag service-api .
sleep 2
cd /Users/khoundokarzahid/Stack/github/FlaskDocker/week4/resources/price_api
docker build --tag price-api .
sleep 2
aws ecr create-repository --repository-name service-api --region us-west-2 --query repository.repositoryUri
aws ecr create-repository --repository-name price-api --region us-west-2 --query repository.repositoryUri
#docker volume create my-named-shared-data

service_api_image_uri=$(eval echo $(aws ecr describe-repositories --repository-name service-api --region us-west-2 --query repositories[0].repositoryUri))
price_api_image_uri=$(eval echo $(aws ecr describe-repositories --repository-name price-api --region us-west-2 --query repositories[0].repositoryUri))
#damn quotes ^
sleep 2
aws ecr get-login --region us-west-2 --no-include-email | /bin/bash
sleep 2
docker tag service-api $service_api_image_uri
docker tag price-api $price_api_image_uri
sleep 2
docker push $service_api_image_uri
docker push $price_api_image_uri
sleep 2
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
cd /home/ec2-user/environment
sudo yum groupinstall -y "Development Tools"
sudo yum install -y zlib-devel openssl-devel ncurses-devel libffi-devel sqlite-devel.x86_64 readline-devel.x86_64 bzip2-devel.x86_64
git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git
./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer
sleep 2
ecs-cli configure --cluster fancy-cluster --default-launch-type EC2 --config-name fancy-cluster --region us-west-2

sleep 4
ecs-cli up --keypair vockey --capability-iam --size 4 --instance-type m4.large --cluster-config fancy-cluster --port 8080 --region us-west-2

cd /home/ec2-user/environment/resources
echo service_api_image_uri=$service_api_image_uri
echo price_api_image_uri=$price_api_image_uri
echo "complete"
