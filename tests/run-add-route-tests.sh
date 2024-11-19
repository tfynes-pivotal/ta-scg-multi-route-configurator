pushd projects

if [ -n "$1" ]; then
  testRoutesList="$1"
else
  testRoutesList="tests-list-added-routes.txt"
fi

echo "file = $testRoutesList"

echo Delete project folders
while IFS= read -r test1; do
    rm -fr ./$test1
    echo
done < "../$testRoutesList"
echo

echo Generate projects
while IFS= read -r test1; do
    echo "Generating Project $test1"
    tanzu acc generate ta-scg-multi-route-configurator --local-server --output-dir ./$test1 --options-file ../$test1.json --extract
    echo
done < "../$testRoutesList"
echo

echo Deploy projects
while IFS= read -r test2; do
    echo "Deploying Project $test2"
    pushd $test2/tpcf-gateway
    ./2-generate-route.sh
    sleep 1
    ./3-deploy-route.sh
    sleep 5
    popd
    echo
done < "../$testRoutesList"
echo


popd projects