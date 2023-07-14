images=`grep image: install.yaml | awk -F 'image: ' '{print $NF}' | sort -n | uniq`

for image in $images
do
  kind load  docker-image $image --name devopscluster
done