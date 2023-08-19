docker build -t custom-build-agent:v1 . 

kind load  docker-image custom-build-agent:v1 --name devopscluster
