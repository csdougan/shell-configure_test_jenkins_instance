#!/bin/bash
SERVER=http://$(minikube ip):30080/
CRUMB=$(curl $SERVER/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))

# Add Docker username and password credentials


curl -H "${CRUMB}" -X POST "${SERVER}/credentials/store/system/domain/_/createCredentials" --data-urlencode "json={
  \"\": \"0\",
  \"credentials\": {
    \"scope\": \"GLOBAL\",
    \"id\": \"dockerlogin\",
    \"username\": \"${DOCKER_USER}\",
    \"password\": \"${DOCKER_PASS}\",
    \"description\": \"hub.docker.com login\",
    \"stapler-class\": \"com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl\"
  }
}"
