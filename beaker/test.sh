#!/usr/bin/env bash

model=allenai/OLMo-2-0425-1B

echo ""
echo "####################################"
echo "### (vllm) Testing generation... ###"
echo "####################################"
echo ""

python beaker/test_generate.py "$model"

echo ""
echo "####################################"
echo "### (vllm) Testing throughput... ###"
echo "####################################"
echo ""

vllm bench throughput \
    --model="$model" \
    --input-len=32 \
    --output-len=1 \
    --enforce-eager \
    --load-format=dummy \
    --output-json=/results/metrics.json
