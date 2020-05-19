# a k8s daemonset to pull node image
running a daemonset on each node to pull images for new nodes.

## Background

For image registries like quay.io,gcr.io,when the pod is scheduled to a new node, the image pull can take very long or just fail.
If the cluster is doing rolling update, and the image pull could take very long and cause extra downtime.
We can pull and push the image from our laptop and push to ecr or docker io, then use node-image-puller to sync the images to the node.

Update the config in config/imagelist or anywhere you like, and set the ENV ${CONFIG_URL} for the DaemonSet, the DaemonSet will sync the config url every 60 seconds, and pull the image for the node.

## Deploy
```shell script
#use helm3 to deploy the service
cd deploy
helm install node-image-puller node-image-puller

#verify the ds is running
duliyang@DuLiyangs-MacBook-Pro deploy % kubectl get pod   
NAME                                      READY   STATUS    RESTARTS   AGE
node-image-puller-5bd9l                   1/1     Running   0          13m
node-image-puller-fpfwj                   1/1     Running   0          13m
node-image-puller-h45x6                   1/1     Running   0          13m
node-image-puller-l7j7p                   1/1     Running   0          13m
node-image-puller-m7dwl                   1/1     Running   0          13m
node-image-puller-mkn7q                   1/1     Running   0          13m
node-image-puller-nw78x                   1/1     Running   0          13m
node-image-puller-r6bdq                   1/1     Running   0          3m34s
node-image-puller-rrrd2                   1/1     Running   0          13m
node-image-puller-tvqvk                   1/1     Running   0          13m
node-image-puller-tzrlg                   1/1     Running   0          13m
node-image-puller-xr8zd                   1/1     Running   0          13m
node-image-puller-zcd8g                   1/1     Running   0          3m36s

#check the logs

download image list from config url:https://raw.githubusercontent.com/Mikedu1988/node-image-puller/master/config/imagelist
rm: can't remove 'imagelist': No such file or directory
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   122  100   122    0     0    425      0 --:--:-- --:--:-- --:--:--   425
duliyang/etcd:v3.2.27|quay.io/coreos/etcd:localtest
time="2020-05-19T11:38:37Z" level=fatal msg="Error parsing image name \"docker-daemon:quay.io/coreos/etcd:localtest\": Error loading image from docker engine: Error response from daemon: reference does not exist"
run command skopeo copy docker://duliyang/etcd:v3.2.27 docker-daemon:quay.io/coreos/etcd:localtest
Getting image source signatures
Copying blob sha256:9d48c3bd43c520dc2784e868a780e976b207cbf493eaff8c6596eb871cbd9609
Copying blob sha256:5d8061a54f4f03695b66369189522f7bdc93b9026a10d194d0568286fb7d9a6d
Copying blob sha256:73ccfe9b4794983ea803c18f7ceff22152152b35e8781ec9eeb09b8945afc62d
Copying blob sha256:4302923581bbdb8adab0963ce94742503ac5c5735d4a0a1fb6ac29fcd58b669c
Copying blob sha256:1b7f10bcf881b3c02facae5cac60c7e86d30141639ec01398440e2b7a16f66d7
Copying blob sha256:6021490514c1175e6dc8f414d9303f40c924fd6a6d20c4e62450a0f9e32942ed
Copying config sha256:e4bec69a2a346190d5e140477e05b6823644ac4180a5467ebf776a7065f1fe67
Writing manifest to image destination
Storing signatures
prom/prometheus:v2.14.0
time="2020-05-19T11:39:02Z" level=fatal m
```

## TODO: add pull secret to support pull from private registry

## TODO: support ECR