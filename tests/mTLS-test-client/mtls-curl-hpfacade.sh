# hp app returns all received request headers as response body
# hpfacade SCG protects hp app, demanding client-side certificate with CN=test-client.fynesy.com
# pass test
curl -vvv --cert cert1.pem --key privkey1.pem https://hpfacade.homelab.fynesy.com/certcheck

# fail test
curl -vvv  https://hpfacade.homelab.fynesy.com/certcheck
