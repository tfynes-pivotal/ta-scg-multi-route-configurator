mkdir ./projects
pushd projects
tanzu acc generate ta-scg-multi-route-configurator --local-server --output-dir ./cpfacade --options-file ../cpfacade.json --extract

popd projects