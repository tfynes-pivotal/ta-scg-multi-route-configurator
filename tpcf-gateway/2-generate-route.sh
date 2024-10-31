ytt -f routeConfig.yaml --output json | jq . > routeConfig.json
curl --request POST 'OPENAPI_TO_ROUTE_CONVERSTION_SERVICE_ENDPOINT' \
--header 'Content-Type: application/json' -d @routeConfig.json | jq . > ./route.json


#CORS-FIX# cp route.json route-no-cors-fixes.yaml
#CORS-FIX# ytt -f ./route-no-cors-fixes.yaml -f ./route-cors-config-overlay.yaml --output json | jq . > route.json

#ADDITIONAL-ROUTES# cp route.json route-no-added-routes.yaml
#ADDITIONAL-ROUTES# tail -n +2 route-additions-data.yaml > tmp.yaml
#ADDITIONAL-ROUTES# cat route-additions-overlay-prefix.yaml tmp.yaml > route-additions-overlay.yaml
#ADDITIONAL-ROUTES# rm tmp.yaml
#ADDITIONAL-ROUTES# ytt -f ./route-no-added-routes.yaml -f ./route-additions-overlay.yaml --output json | jq . > route.json
