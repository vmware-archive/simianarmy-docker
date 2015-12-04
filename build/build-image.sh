#!/bin/bash

VERSION=0.0.1-${CIRCLE_BUILD_NUM}

docker build -t curvelogic/simianarmy-docker:$VERSION .
docker tag curvelogic/simianarmy-docker:$VERSION curvelogic/simianarmy-docker:latest 
