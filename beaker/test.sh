#!/usr/bin/env bash

echo "#####################"
echo "Testing generation..."
echo "#####################"

python beaker/test_generate.py allenai/OLMo-2-0425-1B

echo "#####################"
echo "Testing throughput..."
echo "#####################"

vllm bench throughput \
    --model=allenai/OLMo-2-0425-1B \
    --input-len=32 \
    --output-len=1 \
    --enforce-eager \
    --load-format=dummy \
    --output-json=/results/metrics.json
