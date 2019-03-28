#!/usr/local/bin/bash

set -e;

all_dependencies=(
  paige-app-boilerplate
  paige-app-middleware
  paige-app-error
  paige-app-db
  paige-app-auth
  paige-app-utils
  paige-app-email
  paige-app-logger
);

declare -A dependency_map=(
  [paige-app-boilerplate]="paige-app-auth paige-app-error paige-app-logger"
  [auth-service]="paige-app-boilerplate paige-app-auth paige-app-db"
  [paige-app-middleware]="paige-app-error"
  [paige-app-auth]="paige-app-db paige-app-error"
);

for d in "${all_dependencies[@]}"; do
  cd ${PAIGE_HOME}/$d;
  yarn link;
done;

for K in "${!dependency_map[@]}"; do
  cd ${PAIGE_HOME}/${K};

  module_dependencies=${dependency_map[${K}]};

  for d in $module_dependencies
  do
    yarn link $d;
  done
done
