#!/bin/bash

set -e

if [[ "${DB_CLIENT}" = pg ]]; then
  while ! pg_isready -d "${DB_CONNECTION}" > /dev/null 2> /dev/null; do
    echo "waiting for postgresql server to be ready..."
    sleep 5
  done
fi

cd "${SIGARILLO_DIR}"
echo "initialising / updating database..."
yarn run db:migrate
echo "starting sigarillo..."
exec dumb-init node src/index.js
