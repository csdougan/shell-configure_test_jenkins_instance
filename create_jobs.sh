#!/bin/bash
SERVER=http://$(minikube ip):30080/
CRUMB=$(curl $SERVER/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))
curl -X POST -H $CRUMB "${SERVER}/createItem?name=docker-image-builder" --header "Content-Type: application/xml" -d @jenkins-docker_image_builder-config.xml
