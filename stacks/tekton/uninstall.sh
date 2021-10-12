#!/bin/sh

set -e

if [ -z "${MP_KUBERNETES}" ]; then
  ROOT_DIR=$(git rev-parse --show-toplevel)

  kubectl delete -f "$ROOT_DIR"/stacks/tekton/app.yml
else
  sh -c "curl --location --silent --show-error https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/tekton/app.yml | kubectl delete -f -"
fi
