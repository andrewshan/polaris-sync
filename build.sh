#!/bin/bash

set -o errexit

if [ "$#" -ne 1 ]; then
  echo "Incorrect parameters"
  echo "Usage: build-docker.sh <version>"
  exit 1
fi

VERSION=$1
echo "version is ${VERSION}"
SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

pushd "$SCRIPTDIR/"
#java build the app.
docker run --rm -u root -v "$(pwd)":/home/maven/project -w /home/maven/project maven:3.8.1-openjdk-8-slim mvn clean package

cp "polaris-sync-server/target/polaris-sync-server-${VERSION}.jar" .

zip -r "polaris-sync-server-${VERSION}.zip" "polaris-sync-server-${VERSION}.jar" conf/

popd