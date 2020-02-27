# Toolbox for CTF

## Getting Started

Make sure that there is a data folder in the directory.

*unix  
docker run --rm -v "$(pwd)"/data:/home/ctf/data -it case84/ctf-toolbox

Windows  
docker run --rm -v "${PWD}"/data:/home/ctf/data -it case84/ctf-toolbox

Alternatively you can clone the repo and build the docker container yourself.
