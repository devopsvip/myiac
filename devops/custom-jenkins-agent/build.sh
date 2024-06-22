docker build -t ccr.ccs.tencentyun.com/devopsvip/custom-build-agent:v2 . 

kind load  docker-image ccr.ccs.tencentyun.com/devopsvip/custom-build-agent:v2 --name devopscluster
