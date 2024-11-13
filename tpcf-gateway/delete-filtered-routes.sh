cp routes.json route-pre-delete.json
routes=$(<routes.json)
ytt -f route-removals-data.yaml --output json >  route-removals-data.json
for i in $(cat route-removals-data.json| jq -c '.routes[]'); 
do
    m=$(echo $i | jq -r .method)
    p=$(echo $i | jq -r .path)
    echo filtering method = $m and path = $p
    routes=$(echo $routes | jq "del(.routes[] | select (.method==\"$m\" and .path==\"$p\"))") 
    #cat route-pre-delete.json | jq "del(.routes[] | select (.method==\"$m\" and .path==\"$p\"))" > route-pre-delete.tmp
    #mv route-pre-delete.tmp route-pre-delete.json
done
#mv route-pre-delete.json routes.json
echo $routes | jq . > routes.json