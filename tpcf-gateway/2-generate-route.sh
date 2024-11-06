#CONVERT-SERVICE-DOC# ytt -f routeConfig.yaml --output json | jq . > routeConfig.json
#CONVERT-SERVICE-DOC# curl --request POST 'OPENAPI_TO_ROUTE_CONVERSTION_SERVICE_ENDPOINT' --header 'Content-Type: application/json' -d @routeConfig.json | jq . > ./route.json
#NO-CONVERT-SERVICE-DOC# touch route.json


#CORS-FIX# cp route.json route-no-cors-fixes.json
#CORS-FIX# ytt --file-mark 'route-no-cors-fixes.json:type=yaml-template' -f ./route-no-cors-fixes.json -f ./route-cors-config-overlay.yaml --output json | jq . > route.json


#ADDITIONAL-ROUTES# cp route.json route-no-added-routes.json
#ADDITIONAL-ROUTES# ytt --data-values-file=route-additions-data.yaml --file-mark route-additions-overlay-template.yaml:type=text-template -f route-additions-overlay-template.yaml --output-files output
#ADDITIONAL-ROUTES# cp output/route-additions-overlay-template.yaml ./route-additions-overlay.yaml
#ADDITIONAL-ROUTES# ytt --file-mark 'route-no-added-routes.json:type=yaml-template' -f route-no-added-routes.json -f ./route-additions-overlay.yaml --output json | jq . > ./route.json