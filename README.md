# skedits-app

Recipe for running some skeleton edits analysis in the cloud

## Building/running (on Apple Silicon)

I was having issues with `pip` not finding the right wheels I think since my computer is
ARM architecture - to fix, when building I needed to do:

``docker buildx build --platform linux/amd64 -t skedits .``

And when running:

``docker run --rm --platform linux/amd64 -v /Users/ben.pedigo/.cloudvolume/secrets:/root/.cloudvolume/secrets skedits-app``

There's also:

``docker compose up``

## Publish

To tag:

``docker tag skedits-app bdpedigo/skedits-app:v<X>``

To push

``docker push bdpedigo/skedits-app``
