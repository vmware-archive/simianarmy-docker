#!/bin/bash

VERSION=0.0.1-${CIRCLE_BUILD_NUM}

docker build -t curvelogic/simianarmy:$VERSION .
docker tag curvelogic/simianarmy:$VERSION curvelogic/simianarmy:latest 
