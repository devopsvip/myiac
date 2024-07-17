# Pull images
# docker pull ccr.ccs.tencentyun.com/devopsvip/elasticsearch:8.5.1
# docker pull ccr.ccs.tencentyun.com/devopsvip/kibana:8.5.1
# docker pull ccr.ccs.tencentyun.com/devopsvip/fluent-bit:3.1
# docker pull ccr.ccs.tencentyun.com/devopsvip/busybox:1.30

# Load images to kind cluster
kind load docker-image ccr.ccs.tencentyun.com/devopsvip/fluent-bit:3.1 --name devopscluster
kind load docker-image ccr.ccs.tencentyun.com/devopsvip/kibana:8.5.1 --name devopscluster
kind load docker-image ccr.ccs.tencentyun.com/devopsvip/elasticsearch:8.5.1 --name devopscluster
kind load docker-image ccr.ccs.tencentyun.com/devopsvip/busybox:1.30 --name devopscluster



# after elasticsearch cluster is OK， then set new password

#curl -X POST "https://es.idevops.site/_security/user/elastic/_password" -H "Content-Type: application/json" -k  -u elastic:bJ0tU6YPoKn5GLsJ -d '{"password": "admin123"}'