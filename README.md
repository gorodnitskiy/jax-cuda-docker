# JAX with CUDA support in Docker

There are a lot of issues on GitHub about installing JAX with CUDA support, related to JAX and CUDA/cuDNN versions
mismatching. This repository contains `Dockerfile` that can be used to easily run JAX with CUDA support in Docker.

## Build

It strictly requires to specify, based on existing nvidia docker images on
[NVIDIA Docker hub](https://hub.docker.com/r/nvidia/cuda/tags):

- CUDA (eg: `11.4.3`)
- OS (eg: `ubuntu22.04` or `centos7`)

In case of JAX and CUDA/CUDNN versions mismatching, you have to change `CUDA` and `JAX_CUDA_CUDNN` building variables.

Check JAX versions via [Google Storage](https://storage.googleapis.com/jax-releases/jax_cuda_releases.html).
Check CUDA/cuDNN versions matching via [cuDNN archive](https://developer.nvidia.com/rdp/cudnn-archive).

Each JAX for CUDA compiled with specific cuDNN versions. For example `jaxlib==0.4.2` (CUDA=11) compiled for two
cuDNN versions: 8.2 or 8.6. So, we might choose:

- `CUDA`="11.4.3" and `JAX_CUDA_CUDNN`="cuda11_cudnn82"
- `CUDA`="11.8.0" and `JAX_CUDA_CUDNN`="cuda11_cudnn86"

Also, it might be a problem with overall NVIDIA environment, for example incompatible NVIDIA driver version for
requested CUDA version. It has to be checked apart.

```bash
docker build --tag jax-cuda \
    --build-arg CUDA="11.4.3" \
    --build-arg CUDNN="8" \
    --build-arg TAG="runtime" \
    --build-arg OS="ubuntu20.04" \
    --build-arg JAX_CUDA_CUDNN="cuda11_cudnn82" \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg NAME="user" \
    --build-arg WORKDIR_PATH=$(pwd) .
```

## Run

Some example of running the container:

```bash
docker run \
    --name jax-cuda-test \
    --rm \
    -it \
    -u $(id -u):$(id -g) \
    -v $(pwd):$(pwd):rw \
    jax-cuda:latest
```
