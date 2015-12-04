#!/bin/bash

VERSION=0.0.1-${CIRCLE_BUILD_NUM}

docker push curvelogic/simianarmy-docker:$VERSION
docker push curvelogic/simianarmy-docker:latest
