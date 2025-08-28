#!/usr/bin/env bash

set -e

vllm_commit="f9ca2b40a0357d98e3fb8bd951745dfaceab459e"
image_name="vllm-test-$vllm_commit"
workspace=ai2/vllm_testing
beaker_user=$(beaker account whoami --format=json | jq -r '.[0].name')
timestamp=$(date "+%Y%m%d%H%M%S")

docker build -f beaker/Dockerfile -t "$image_name" --build-arg VLLM_COMMIT="$vllm_commit" .
echo "Built image '$image_name', size: $(docker inspect -f '{{ .Size }}' $image_name | numfmt --to=si)"

beaker image create "$image_name" --name "${image_name}-tmp" --workspace "$workspace"
beaker image rename "${beaker_user}/${image_name}" "${image_name}-${timestamp}" >/dev/null 2>&1 || true
beaker image rename "${beaker_user}/${image_name}-tmp" "${image_name}"
echo "Done."
