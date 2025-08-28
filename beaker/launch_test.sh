#!/usr/bin/env bash

export VLLM_COMMIT="f9ca2b40a0357d98e3fb8bd951745dfaceab459e"
export VLLM_PRECOMPILED_WHEEL_LOCATION="https://wheels.vllm.ai/${VLLM_COMMIT}/vllm-1.0.0.dev-cp38-abi3-manylinux1_x86_64.whl"

gantry run \
    --show-logs \
    --yes \
    --allow-dirty \
    --workspace=ai2/vllm_testing \
    --name="vllm-test-$(date +%Y%m%d-%H%M%S)" \
    --priority=normal \
    --task-timeout=30m \
    --gpu-type=h100 \
    --gpus=1 \
    --beaker-image="petew/vllm-test-${VLLM_COMMIT}" \
    --uv-venv='/root/venv' \
    --env='VLLM_USE_PRECOMPILED=1' \
    --env='VLLM_COMMIT' \
    --env='VLLM_PRECOMPILED_WHEEL_LOCATION' \
    --install="uv pip install --editable . --torch-backend=cu128" \
    -- ./beaker/test.sh
