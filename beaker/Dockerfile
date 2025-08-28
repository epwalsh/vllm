# Adapted from beaker-gantry's Dockerfile.
ARG BASE_IMAGE=nvidia/cuda:12.8.1-base-ubuntu22.04
FROM ${BASE_IMAGE}

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       build-essential \
       ca-certificates \
       curl \
       wget \
       libxml2-dev \
       jq \
       cmake \
       git && \
    rm -rf /var/lib/apt/lists/* && \
    curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH=~/.local/bin:$PATH

RUN ~/.local/bin/uv venv --python=3.12 --no-project --no-config --seed ~/venv

ARG VLLM_COMMIT=f9ca2b40a0357d98e3fb8bd951745dfaceab459e
RUN . ~/venv/bin/activate && \
    ~/.local/bin/uv pip install vllm --torch-backend=cu128 --extra-index-url=https://wheels.vllm.ai/${VLLM_COMMIT} && \
    ~/.local/bin/uv pip uninstall vllm

WORKDIR ~/
ENTRYPOINT ["/bin/bash"]
