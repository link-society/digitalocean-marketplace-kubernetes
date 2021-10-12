#!/bin/sh

set -e

if [ -z "${MP_KUBERNETES}" ]; then
  ROOT_DIR=$(git rev-parse --show-toplevel)
  sh "$ROOT_DIR"/stacks/kapp-controller/deploy.sh

  kubectl apply -f "$ROOT_DIR"/stacks/tekton/app.yml
else
  sh -c "curl --location --silent --show-error https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/kapp-controller/deploy.sh | sh"
  sh -c "curl --location --silent --show-error https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/tekton/app.yml | kubectl apply -f -"
fi

kubectl wait --for=condition=ReconcileSucceeded app/tekton-pipelines
