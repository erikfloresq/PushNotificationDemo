#!/usr/bin/env bash

export TEAM_ID={your TEAM ID}
export TOKEN_KEY_FILE_NAME={your p8 path} #/Users/erikflores/keys/AuthKey.p8
export AUTH_KEY_ID={your Key ID}
export DEVICE_TOKEN={your device token}
export TOPIC={App ID}
export APNS_HOST_NAME=api.sandbox.push.apple.com

export JWT_ISSUE_TIME=$(date +%s)
export JWT_HEADER=$(printf '{ "alg": "ES256", "kid": "%s" }' "${AUTH_KEY_ID}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
export JWT_CLAIMS=$(printf '{ "iss": "%s", "iat": %d }' "${TEAM_ID}" "${JWT_ISSUE_TIME}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
export JWT_HEADER_CLAIMS="${JWT_HEADER}.${JWT_CLAIMS}"
export JWT_SIGNED_HEADER_CLAIMS=$(printf "${JWT_HEADER_CLAIMS}" | openssl dgst -binary -sha256 -sign "${TOKEN_KEY_FILE_NAME}" | openssl base64 -e -A | tr -- '+/' '-_' | tr -d =)
export AUTHENTICATION_TOKEN="${JWT_HEADER}.${JWT_CLAIMS}.${JWT_SIGNED_HEADER_CLAIMS}"

curl -v \
--header "apns-topic: $TOPIC" \
--header "apns-push-type: alert" \
--header "authorization: bearer $AUTHENTICATION_TOKEN" \
--data \
'{"aps": {
   "alert": {
      "title": "Tu orden esta llengando!",
      "body": "No te olvides de darle propina al rider"
   }
}}' \
--http2 \
https://${APNS_HOST_NAME}/3/device/$DEVICE_TOKEN