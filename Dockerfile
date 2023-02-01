ARG CUDA="11.4.3"
ARG CUDNN="8"
ARG TAG="devel"
ARG OS="ubuntu20.04"
FROM nvidia/cuda:${CUDA}-cudnn${CUDNN}-${TAG}-${OS}

RUN apt-get update && \
    apt-get install -y \
        git \
        vim \
        htop \
        python3 \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

ARG USER_ID
ARG GROUP_ID
ARG NAME
RUN groupadd --gid ${GROUP_ID} ${NAME}
RUN useradd \
    --no-log-init \
    --create-home \
    --uid ${USER_ID} \
    --gid ${GROUP_ID} \
    -s /bin/sh ${NAME}

ARG WORKDIR_PATH
WORKDIR ${WORKDIR_PATH}

ARG JAX_CUDA_CUDNN="cuda"

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install "jax[$JAX_CUDA_CUDNN]" \
        -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
