ytt -f gateway.yaml --output json | jq -r . > gateway.json
cf create-service p.gateway standard GATEWAY_NAME -c ./gateway.json -w