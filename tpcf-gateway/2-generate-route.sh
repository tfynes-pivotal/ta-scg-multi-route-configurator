ytt -f routeConfig.yaml --output json | jq . > routeConfig.json
curl --request POST 'OPENAPI_TO_ROUTE_CONVERSTION_SERVICE_ENDPOINT' \
--header 'Content-Type: application/json' -d @routeConfig.json | jq . > ./route.json


#C-FIX# cp route.json route-no-cors-fixes.yaml
#C-FIX# ytt -f ./route-no-cors-fixes.yaml -f ./route-cors-config-overlay.yaml --output json | jq . > route.json

#CORS-FIX# cp route.json route-no-cors-fixes.json
#CORS-FIX# ytt --file-mark 'route-no-cors-fixes.json:type=yaml-template' -f ./route-no-cors-fixes.json -f ./route-cors-config-overlay.yaml --output json | jq . > route.json

#A-ROUTES# cp route.json route-no-added-routes.yaml
#A-ROUTES# tail -n +2 route-additions-data.yaml > tmp.yaml
#A-ROUTES# cat route-additions-overlay-prefix.yaml tmp.yaml > route-additions-overlay.yaml
#A-ROUTES# rm tmp.yaml
#A-ROUTES# ytt -f ./route-no-added-routes.yaml -f ./route-additions-overlay.yaml --output json | jq . > route.json

# ytt --data-values-file=route-additions-data.yaml -f route-additions-overlay-prefix.txt --output-files output
# cp output/route-additions-overlay-prefix.txt output/route-additions-overlay-prefix.yaml
# ytt -f route-additions-data.yaml -f output/route-additions-overlay-prefix.txt > output/route.json

#A-ROUTES# cp route.json route-no-added-routes.yaml
#A-ROUTES# ytt --data-values-file=route-additions-data.yaml --file-mark route-additions-overlay-template.yaml:type=text-template -f route-additions-overlay-template.yaml --output-files output
#A-ROUTES# cp output/route-additions-overlay-template.yaml ./route-additions-overlay.yaml
#A-ROUTES# ytt f route-no-added-routes.yaml - -f ./route-additions-overlay.yaml --output json | jq . > ./route.json

#ADDITIONAL-ROUTES# cp route.json route-no-added-routes.json
#ADDITIONAL-ROUTES# ytt --data-values-file=route-additions-data.yaml --file-mark route-additions-overlay-template.yaml:type=text-template -f route-additions-overlay-template.yaml --output-files output
#ADDITIONAL-ROUTES# cp output/route-additions-overlay-template.yaml ./route-additions-overlay.yaml
#ADDITIONAL-ROUTES# ytt --file-mark 'route-no-added-routes.json:type=yaml-template' -f route-no-added-routes.json -f ./route-additions-overlay.yaml --output json | jq . > ./route.json