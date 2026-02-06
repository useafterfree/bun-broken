Docker builds using api-reference-react will fail in docker.

App created with: `bun create next-app bun-broken`
Docker configs from Next.js https://github.com/vercel/next.js/tree/canary/examples/with-docker
Created a simple api-reference-react from: https://scalar.com/products/api-references/integrations/react

# Reproduce:
- `git clone https://github.com/useafterfree/bun-broken`
- `make install`
- `make node` ## fails
- `make bun` ## fails


- this will fail with @scalar/api-reference-react ^0.8.48:
failure with `make node`:
```
#17 8.810 [1m[31mFATAL[39m[0m: An unexpected Turbopack error occurred. A panic log has been written to /tmp/next-panic-5509dee03f8cf9fe407a1492f4eb5e2c.log.
#17 8.810 
#17 8.810 To help make Turbopack better, report this error by clicking here: https://github.com/vercel/next.js/discussions/new?category=turbopack-error-report&title=Turbopack%20Error%3A%20NftJsonAsset%3A%20cannot%20handle%20filepath%20url&body=Turbopack%20version%3A%20%6023c46498%60%0ANext.js%20version%3A%20%600.0.0%60%0A%0AError%20message%3A%0A%60%60%60%0ATurbopack%20Error%3A%20NftJsonAsset%3A%20cannot%20handle%20filepath%20url%0A%60%60%60&labels=Turbopack,Turbopack%20Panic%20Backtrace
#17 8.810 -----
#17 8.810 
#17 9.235 
#17 9.235 > Build error occurred
#17 9.242 Error [TurbopackInternalError]: NftJsonAsset: cannot handle filepath url
```


failure with `make bun`:
```
#13 8.828 > Build error occurred
#13 8.831 Error [TurbopackInternalError]: NftJsonAsset: cannot handle filepath url
#13 8.831 
```
