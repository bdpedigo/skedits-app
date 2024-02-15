# skedits-app

Recipe for running some skeleton edits analysis in the cloud

## Building/running (on Apple Silicon)

I was having issues with `pip` not finding the right wheels I think since my computer is
ARM architecture - to fix, when building I needed to do:

``docker buildx build --platform linux/amd64 -t skedits-app .``

And when running:

``docker run --rm --platform linux/amd64 -v /Users/ben.pedigo/.cloudvolume/secrets:/root/.cloudvolume/secrets skedits-app``

There's also:

``docker compose up``

## Publish

To tag:

``docker tag skedits-app bdpedigo/skedits-app:v<X>``

To push

``docker push bdpedigo/skedits-app:v<X>``

## If running out of space

``docker system prune -a``

## Making a cluster
 
``sh ./make_cluster.sh``

## Configuring a cluster 

``kubectl apply -f kube-task.yml``

## Monitor the cluster

``kubectl get pods``

## Watch the logs in real-time 

``kubectl logs -f <pod-name>``