#!/bin/bash
set -eu

THIS_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

touch $THIS_PATH/schema.rb

docker-compose run app rails db:migrate

for SCHEMA_FILE in 'schema.rb'; do
  docker-compose run --no-deps -T app cat db/$SCHEMA_FILE > /tmp/$SCHEMA_FILE
  if ! diff -q $THIS_PATH/$SCHEMA_FILE /tmp/$SCHEMA_FILE > /dev/null 2>&1; then
    echo "Saving $SCHEMA_FILE"
    cp /tmp/$SCHEMA_FILE $THIS_PATH/$SCHEMA_FILE
  fi
done