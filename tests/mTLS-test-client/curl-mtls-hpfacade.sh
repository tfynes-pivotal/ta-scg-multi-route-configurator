# hp app returns all received request headers as response body
# hpfacade SCG protects hp app, demanding client-side certificate with CN=test-client.fynesy.com
tar zxvf ./test-client-demo-cert-key.zip
# pass test
echo
echo PASS TEST
echo
curl -vvv --cert cert1.pem --key privkey1.pem https://hpfacade.homelab.fynesy.com/certcheck
echo 
echo
echo FAIL TEST
echo
# fail test
curl -vvv  https://hpfacade.homelab.fynesy.com/certcheck
