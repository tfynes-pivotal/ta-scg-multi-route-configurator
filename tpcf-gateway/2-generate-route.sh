ytt -f routeConfig.yaml --output json > routeConfig.json
curl --request POST 'OPENAPI_TO_ROUTE_CONVERSTION_SERVICE_ENDPOINT' \
--header 'Content-Type: application/json' -d @routeConfig.json | jq . > ./route.json