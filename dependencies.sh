#!/usr/local/bin/bash

set -e;

all_dependencies=(
  paige-app-boilerplate
  paige-app-server
  paige-app-middleware
  paige-app-error
  paige-app-model
  paige-app-db
  paige-app-auth
  paige-app-utils
  paige-app-email
  paige-app-logger
);

declare -A dependency_map=(
  [paige-app-server]="paige-app-logger"
  [paige-app-boilerplate]="paige-app-auth paige-app-error"
  [auth-service]="paige-app-server paige-app-boilerplate paige-app-auth"
  [paige-app-middleware]="paige-app-error"
  [paige-app-auth]="paige-app-model paige-app-error"
);

for d in "${all_dependencies[@]}"; do
  cd ${PAIGE_HOME}/$d;
  yarn link;
done;

for K in "${!dependency_map[@]}"; do
  cd ${PAIGE_HOME}/$K;

  module_dependencies=${DEPENDENCY_MAP[${K}]};

  for d in $module_dependencies
  do
    yarn link $d;
  done
done
