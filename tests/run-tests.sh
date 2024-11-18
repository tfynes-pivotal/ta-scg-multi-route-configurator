
if [ -n "$1" ]; then
  testsList="$1"
else
  testsList="tests-list.txt"
fi


rm -fr ./projects
mkdir ./projects
pushd projects


echo Delete Services asynchronously
while IFS= read -r test1; do
    echo "Deleting Service $test1"
    cf delete-service $test1 -f 
    echo
done < "../$testsList"
echo

echo Wait for Deletes to Finish
while IFS= read -r test2; do
    echo "Waiting for Deletion of $test2"
    ../wait-for-service-delete.sh $test2    
    echo
done < "../$testsList"
echo
echo sleeping
sleep 2

# cp-basic
#tanzu acc generate ta-scg-multi-route-configurator --local-server --output-dir ./cp-basic --options-file ../cp-basic.json --extract

# cp-basic-cors
#tanzu acc generate ta-scg-multi-route-configurator --local-server --output-dir ./cp-basic-cors --options-file ../cp-basic-cors.json --extract


echo Generate projects
while IFS= read -r test3; do
    echo "Generating Project $test3"
    tanzu acc generate ta-scg-multi-route-configurator --local-server --output-dir ./$test3 --options-file ../$test3.json --extract
    sleep 5
    echo
done < "../$testsList"
echo

echo Deploy projects
echo ls $(ls)
while IFS= read -r test4; do
    echo "Deploying Project $test4" 
    pushd $test4/tpcf-gateway
    ./create-generate-deploy.sh  
    sleep 30
    popd
    echo
done < "../$testsList"
echo


popd 