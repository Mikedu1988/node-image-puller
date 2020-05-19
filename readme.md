# a k8s daemonset to pull node image
running a daemonset on each node to pull images for new nodes.

## Background
For image registries like quay.io,gcr.io,when the pod is scheduled to a new node, the image pull can take very long or just fail.
If the cluster is doing rolling update, and the image pull could take very long and cause extra downtime.
We can pull and push the image from our laptop and push to ecr or docker io, then use node-image-puller to sync the images to the node.

Update the config in config/imagelist or anywhere you like, and set the ENV ${CONFIG_URL} for the DaemonSet, the DaemonSet will sync the config url every 60 seconds, and pull the image for the node.

## TODO: add pull secret to support pull from private registry
## TODO: support ECR