#!/bin/bash

VERSION=0.0.1-${CIRCLE_BUILD_NUM}

docker push curvelogic/simianarmy:$VERSION
docker push curvelogic/simianarmy:latest
