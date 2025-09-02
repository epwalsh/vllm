#!/usr/bin/env bash

model=allenai/OLMo-2-0425-1B

echo "Starting vllm tests with model '$model'..."

echo ""
echo -e "\e[36m\e[1m####################################\e[0m"
echo -e "\e[36m\e[1m### (vllm) Testing generation... ###\e[0m"
echo -e "\e[36m\e[1m####################################\e[0m"
echo ""

python beaker/test_generate.py "$model"

echo ""
echo -e "\e[36m\e[1m####################################\e[0m"
echo -e "\e[36m\e[1m### (vllm) Testing throughput... ###\e[0m"
echo -e "\e[36m\e[1m####################################\e[0m"
echo ""

vllm bench throughput \
    --model="$model" \
    --input-len=32 \
    --output-len=1 \
    --enforce-eager \
    --load-format=dummy \
    --output-json=/results/metrics.json
