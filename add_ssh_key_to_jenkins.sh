#!/bin/bash
SERVER=http://$(minikube ip):30080/
CRUMB=$(curl $SERVER/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))
SSH_PRIV_KEY=$(sed 's/$/\\n/g' ~/.ssh/bb_read_key|tr '\n' '*'|sed 's/*//g')
# Add SSH Key for Bitbucket

SSH_PRIV_KEY=$(echo $SSH_PRIV_KEY)
curl -H "${CRUMB}" -X POST "${SERVER}/credentials/store/system/domain/_/createCredentials" --data-urlencode "json={
  \"\": \"0\",
  \"credentials\": {
    \"scope\": \"GLOBAL\",
    \"id\": \"apicredentials\",
    \"username\": \"apicredentials\",
    \"password\": \"\",
    \"privateKeySource\": {
      \"stapler-class\": \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\$DirectEntryPrivateKeySource\",
      \"privateKey\": \"${SSH_PRIV_KEY}\",
    },
    \"description\": \"apicredentials\",
    \"stapler-class\": \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\"
  }
}"
