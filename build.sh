#!/bin/bash
set -o errexit
export DOCKER_BUILDKIT=1
export PROGRESS_NO_TRUNC=1

# shellcheck disable=SC2046
docker build --tag jax-cuda \
    --build-arg CUDA="11.4.3" \
    --build-arg OS="ubuntu20.04" \
    --build-arg JAX_CUDA_CUDNN="cuda11_cudnn82" \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
    --build-arg NAME="user" \
    --build-arg WORKDIR_PATH=$(pwd) .
