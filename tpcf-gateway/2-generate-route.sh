#CONVERT-SERVICE-DOC# ytt -f routeConfig.yaml --output json | jq . > routeConfig.json
#CONVERT-SERVICE-DOC# curl --request POST 'OPENAPI_TO_ROUTE_CONVERSTION_SERVICE_ENDPOINT' --header 'Content-Type: application/json' -d @routeConfig.json | jq . > ./routes.json
#NO-CONVERT-SERVICE-DOC# echo '{"routes": []}' > routes.json


#CORS-FIX# cp routes.json route-no-cors-fixes.json
#CORS-FIX# ytt --file-mark 'route-no-cors-fixes.json:type=yaml-template' -f ./route-no-cors-fixes.json -f ./route-cors-config-overlay.yaml --output json | jq . > routes.json


#ADDITIONAL-ROUTES# cp routes.json route-no-added-routes.json
#ADDITIONAL-ROUTES# ytt  --data-values-file=service-predicates-additions-data.yaml  --data-values-file=route-additions-data.yaml --file-mark route-additions-overlay-template.yaml:type=text-template -f route-additions-overlay-template.yaml --output-files output
#ADDITIONAL-ROUTES# cp output/route-additions-overlay-template.yaml ./route-additions-overlay.yaml
#ADDITIONAL-ROUTES# ytt --file-mark 'route-no-added-routes.json:type=yaml-template' -f route-no-added-routes.json -f ./route-additions-overlay.yaml --output json | jq . > ./routes.json

#NOTES-REMOVE-ROUTES# cat routes.json | jq 'del(.routes[] | select ( .method == "GET" and .path == "/api/foo"))'
#NOTES-REMOVE-ROUTES# for i in $(cat route-removals-data.json| jq -c '.routes[]'); do echo $i | jq .method && echo; done
#NOTES-REMOVE-ROUTES# cat routes.json| jq '.routes[] | .method + " " + .path'

#REMOVE-ROUTES# ./delete-filtered-routes.sh
