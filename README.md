# skedits-app
Recipe for 

## Apple Silicon
I was having issues with `pip` not finding the right wheels I think since my computer is
ARM architecture - to fix, when building I needed to do:

``docker buildx build --platform linux/amd64 -t skedits .``

And when running: 
``docker run --rm --platform linux/amd64 skedits``