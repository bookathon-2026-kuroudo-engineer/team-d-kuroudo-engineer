#!/bin/bash
set -eu

REVIEW_CONFIG_FILE=${REVIEW_CONFIG_FILE:-config.yml}
REVIEW_DOCKER_IMAGE=${REVIEW_DOCKER_IMAGE:-team-d-kuroudo-engineer-review:5.9}

# コマンド手打ちで作業したい時は以下の通り /book に pwd がマウントされます
# docker run -i -t -v "$(pwd):/book" team-d-kuroudo-engineer-review:5.9 /bin/bash

docker build -t "$REVIEW_DOCKER_IMAGE" .
docker run -t --rm \
  -v "$(pwd):/book" \
  -e REVIEW_CONFIG_FILE="$REVIEW_CONFIG_FILE" \
  "$REVIEW_DOCKER_IMAGE" \
  /bin/bash -ci 'cd /book && ./setup.sh && npm run pdf'
